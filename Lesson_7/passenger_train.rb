# frozen_string_literal: true

require_relative 'train'

# passenger train
class PassengerTrain < Train
  def attach_wagon(wagon)
    return unless wagon.is_a?(PassengerWagon)

    super
  end
end
