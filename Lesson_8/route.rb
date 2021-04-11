# frozen_string_literal: true

require_relative 'validatable'

# Route
class Route
  include InstanceCounter
  include Validatable
  include Validatable::RouteValidation

  attr_reader :stations

  def initialize(first_station, last_station)
    validate!(first_station, last_station)
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

  private

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end
end
