# frozen_string_literal: true

# Validatable
module Validatable
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  # Validating Station
  module StationValidation
    def validate!
      name_length_error
      name_empty_error
      name_inclusion_error
    end

    private

    def name_length_error
      raise 'invalid length' if name.length < 3 || name.length > 20
    end

    def name_empty_error
      raise "name can't be empty" if name.empty?
    end

    def name_inclusion_error
      return if name.split(' ').all? do |char|
        char =~ /[0-9]/
      end

      raise 'name should include at least one char'
    end
  end

  # Validating Route
  module RouteValidation
    def validate!(first_station, last_station)
      station_inclusion_error(first_station, last_station)
    end

    private

    def station_inclusion_error(first_station, last_station)
      return unless [first_station, last_station].all? do |station|
        station.instance_of?(Station)
      end

      raise 'route can consist only out of stations'
    end
  end

  # Validating Train
  module TrainValidation
    def validate!
      number_empty_error
      number_format_error
    end

    private

    def number_empty_error
      raise "number can't be empty" unless number
    end

    def number_format_error
      return unless number =~ /[a-z0-9]{3}-?[a-z0-9]{2}/

      raise 'invalid format of the number'
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

# class Station
#   include Validation

#   validate :name, :presence
#   validate :name, :type, String
#   validate :number, :format, /[a-z0-9]{3}-?[a-z0-9]{2}/

#   attr_reader :name, :trains

#   def initialize(name, number)
#     @name = name
#     @number = number
#     validate!
#     @trains = []
#   end
# end

# station = Station.new('hello', '12332')
