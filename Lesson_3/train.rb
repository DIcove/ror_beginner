# frozen_string_literal: true

# Train
class Train
  STEP = 1
  attr_accessor :speed, :route
  attr_reader :type, :wagons, :number

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
  end

  def gain_speed
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def attach_wagon
    speed.zero ? self.wagons += 1 : "can't attach wagons while moving..."
  end

  def add_route(route)
    return 'not a route...' unless route.instance_of?(Route)

    self.route = route
    @index = 0
    current_station.join(self)
  end

  def previous_station
    route.stations[@index - STEP]
  end

  def current_station
    route.stations[@index]
  end

  def next_station
    route.stations[@index + STEP]
  end

  def move_forward
    return 'ur currently on the last available station...' if next_station.nil?

    current_station.send(self)
    next_station.join(self)
    self.index += STEP
  end

  def move_back
    return 'ur currenlty on the first available station...' if previous_station.nil?

    current_station.send(self)
    previous_station.join(self)
    self.index -= STEP
  end
end
