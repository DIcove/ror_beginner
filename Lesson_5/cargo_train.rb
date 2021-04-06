require_relative 'train'

# cargo train
class CargoTrain < Train
  def attach_wagon(wagon)
    return unless wagon.type.downcase('cargo')

    super
  end
end
