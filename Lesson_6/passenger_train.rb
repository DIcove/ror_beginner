require_relative 'train'

# passenger train
class PassengerTrain < Train
  def attach_wagon(wagon)
    return unless wagon.type.downcase('passenger')

    super
  end
end
