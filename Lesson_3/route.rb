# frozen_string_literal: true

# Route
class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def add_station(station)
    return if stations.include?(station)

    stations << station
  end

  def remove_station(station)
    return if [first_station, last_station].include? station

    stations.delete(station)
  end
end

=begin 
вот в этом коде (с intermediate_stations), никак не могу сообразить как лучше реализовать метод stations
без геттеров к инстанс переменным (тк если получать через метод, то получается бесконечный вызов)
=end

# class Route
#   attr_reader :intermediate_stations

#   def initialize(first_station, last_station)
#     @intermediate_stations = []
#   end

#   def first_station
#     stations.first
#   end

#   def last_station
#     stations.last
#   end

#   def stations
#     intermediate_stations.insert(0, first_station)
#     intermediate_stations.insert(-1, last_station)
#   end

#   def add_station(station)
#     return if stations.include?(station)

#     intermediate_stations << station
#   end

#   def remove_station(station)
#     intermediate_stations.delete(station)
#   end
# end
