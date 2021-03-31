# frozen_string_literal: true

# Train
class Train
  attr_reader :type, :number, :speed, :wagons

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
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

  private #потому что пиже приведенные методы не обязательны для юзера, однако важды для работы публичных методов

  STEP = 1

  attr_accessor :speed, :route, :index

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
