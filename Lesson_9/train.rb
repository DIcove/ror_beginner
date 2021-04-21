# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
# require_relative 'validatable'
require_relative 'validation'

# Train
class Train
  include Manufacturer
  include InstanceCounter
  # include Validatable
  # include Validatable::TrainValidation
  include Validation

  validate :number, :format, /[a-z0-9]{3}-?[a-z0-9]{2}/

  @trains = {}

  class << self
    attr_reader :trains
  end

  def self.find(num)
    trains[num]
  end

  attr_reader :type, :number, :speed, :wagons

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @wagons = []
    self.class.trains[number] = self
    register_instance
  end

  def gain_speed
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    wagons << wagon if stopped?
  end

  def remove_wagon(wagon)
    wagons.delete(wagon) if stopped?
  end

  def stopped?
    speed.zero?
  end

  def assign_route(route)
    @route = route
    @index = 0
    current_station.join(self)
  end

  def move_forward
    return unless next_station

    current_station.send(self)
    next_station.join(self)
    self.index += STEP
  end

  def move_back
    return unless previous_station

    current_station.send(self)
    previous_station.join(self)
    self.index -= STEP
  end

  def wagons_method(_block, &block)
    wagons.each(&block)
  end

  private

  STEP = 1

  attr_writer :speed
  attr_accessor :route, :index

  def previous_station
    return if index.zero?

    route.stations[index - STEP]
  end

  def current_station
    route.stations[index]
  end

  def next_station
    route.stations[index + STEP]
  end
end