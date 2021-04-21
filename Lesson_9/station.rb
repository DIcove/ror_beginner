# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
# require_relative 'validatable'

# Station
class Station
  include InstanceCounter
  # include Validatable
  # include Validatable::StationValidation
  include Validation

  validate :name, :presence
  validate :name, :format, /[A-Za-z]/
  validate :name, :type, String

  @stations = []

  class << self
    attr_reader :stations
  end

  def self.all
    stations
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.stations << self
    register_instance
  end

  def join(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def cargo_trains
    trains.select { |t| t.type.downcase == 'cargo' }
  end

  def passenger_trains
    trains.select { |t| t.type.downcase == 'passenger' }
  end

  def trains_method(block)
    trains.each { |train| block.call(train) }
  end
end
