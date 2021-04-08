require_relative 'wagon'

# passenger wagon
class PassengerWagon < Wagon
  attr_reader :taken_steats, :seats

  def initialize(seats)
    @seats = seats
    @taken_seats = 0
  end

  def take_seat
    raise if seats.zero?

    self.seats -= 1
    self.taken_seats += 1
  rescue RuntimeError
    puts 'You are out of seats!'
  end

  private

  attr_writer :seats, :taken_seats
end
