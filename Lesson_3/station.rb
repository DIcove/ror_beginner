# frozen_string_literal: true

# Station
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def join(train)
    return unless train.instance_of?(Train)

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
