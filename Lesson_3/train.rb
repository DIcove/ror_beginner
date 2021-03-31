# frozen_string_literal: true

# Train
class Train
  STEP = 1
  attr_accessor :speed, :route, :index
  attr_reader :type, :wagons, :number

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def gain_speed
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def attach_wagon
    self.wagons += 1 if speed.zero?
  end

  def add_route(route)
    @route = route
    @index = 0
    current_station.join(self)
  end

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
end
