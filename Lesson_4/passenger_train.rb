require_relative 'train'

# passenger train
class PassengerTrain < Train
  def attach_wagon(wagon)
    return unless wagon.instance_of?(PassengerWagon)

    super
  end
end
