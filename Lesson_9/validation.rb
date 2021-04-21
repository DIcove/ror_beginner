# frozen_string_literal: true

# Validation
module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  # Class methods
  module ClassMethods
    attr_reader :validations

    def validate(attr_name, procedure, args = nil)
      @validations ||= []
      validations << {
        attr_name: attr_name,
        procedure: procedure,
        args: args
      }
    end
  end

  # instance methods
  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr_val = instance_variable_get("@#{validation[:attr_name]}")
        send(validation[:procedure], attr_val, validation[:args])
      end
    end

    def valid?
      validate!
      true
    rescue NameError
      false
    end

    private

    def presence(attr_val, _)
      raise NameError, error(__method__, attr_val) if attr_val.nil? || attr_val == ''
    end

    def format(attr_val, expression)
      raise NameError, error(__method__, attr_val, expression) unless attr_val =~ expression
    end

    def type(attr_val, type)
      raise NameError, error(__method__, attr_val, type) unless attr_val.instance_of?(type)
    end

    def error(method, attr_val, args = 'no args')
      "validation #{method}, on #{attr_val} with arguments: #{args} failed"
    end
  end
end

# Все же не понял, как можно использовать инстанс методы внурти метода класса # rubocop:todo Style/AsciiComments
# class Test
#   def self.class_method
#     obj = new
#     block = -> { puts 'hello' }
#     obj.class.send(:define_method, :instance_method, &block)
#     send(:instance_method)
#   end
# end
