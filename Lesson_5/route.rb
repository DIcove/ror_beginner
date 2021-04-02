# frozen_string_literal: true

# Route
class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    return if stations.include?(station)

    stations << station
  end

  def remove_station(station)
    return if [first_station, last_station].include? station

    stations.delete(station)
  end

  def name
    "#{first_station.name}-#{last_station.name}"
  end

  private #потому, что юзеру нет необходимости в использовании этих методов, однако он нужны для выполнения публичных методов

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end
end
