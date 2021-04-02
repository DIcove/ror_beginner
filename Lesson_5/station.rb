# frozen_string_literal: true

require_relative 'instance_counter'

# Station
class Station
  include InstanceCounter

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def join(train)
    trains << train
  end

  def send(train)
    trains.delete(train)
  end

  def cargo_trains
    trains.select { |t| t.type.downcase == 'cargo' }
  end

  def passenger_trains
    trains.select { |t| t.type.downcase == 'passenger' }
  end
end
