require_relative 'train'

# cargo train
class CargoTrain < Train
  def attach_wagon(wagon)
    return unless wagon.instance_of?(CargoWagon)

    super
  end
end
