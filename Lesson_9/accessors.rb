# frozen_string_literal: true

# accessors
module Accessors
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  # class methods
  module ClassMethods
    def attributes
      @attributes ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def my_attr_reader(name, var_name)
      define_method(name) { instance_variable_get(var_name) }
    end

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}"
        my_attr_reader(name, var_name)
        define_method("#{name}=") do |value|
          instance_variable_set(var_name, value)
          self.class.attributes[name.to_sym] << value
        end
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}"
      my_attr_reader(name, var_name)
      define_method("#{name}=") do |value|
        begin
          raise TypeError unless value.instance_of?(type)

          instance_variable_set(var_name, value)
        rescue TypeError
          puts 'invalid type'
        end
      end
    end
  end
end

# instance methods
module InstanceMethods
  def method_missing(name, *_args) # rubocop:todo Style/MissingRespondToMissing
    default_name = name.to_s.gsub('_history', '').to_sym
    obj_class = self.class
    obj_class.send(:define_method, name.to_sym, -> { obj_class.attributes[default_name] })
    instance_eval "self.#{name}", __FILE__, __LINE__
  end
end

class Test
  include Accessors

  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :d, Integer
end

# t = Test.new
# t.a = 1
# t.b = 2
# t.c = 3

# t.d = 1
# p t.a

# puts "before: #{Test.attributes.inspect}"
# t.a = 2
# puts "after: #{Test.attributes.inspect}"

# p t.a_history

# p Test.instance_methods

# p t.a_history
