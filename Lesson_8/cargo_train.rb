# frozen_string_literal: true

require_relative 'train'

# cargo train
class CargoTrain < Train
  def attach_wagon(wagon)
    return unless wagon.is_a?(CargoWagon)

    super
  end
end
