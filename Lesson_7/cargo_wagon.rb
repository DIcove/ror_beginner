require_relative 'wagon'

# cargo wagon
class CargoWagon < Wagon
  attr_reader :available_volume, :taken_volume

  def initialize(available_volume)
    @available_volume = available_volume
    @taken_volume = 0
  end

  def take_volume(volume)
    raise if available_volum < volume

    self.available_volume -= volume
    self.taken_volume += volume
  rescue RuntimeError
    puts 'you\'re out of available volume'
  end

  private

  attr_writer :available_volume, :taken_volume
end
