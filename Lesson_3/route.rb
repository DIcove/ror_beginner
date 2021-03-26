# frozen_string_literal: true

# Route
class Route
  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
    stations.push(first_station, last_station)
  end

  def add_station(station)
    return 'station already in list...' if stations.include?(station)

    stations.insert(1, station)
  end

  def remove_station(station)
    return "you can't remove first and last stations..." if station == first_station || station == last_station

    stations.delete(station)
  end
end
