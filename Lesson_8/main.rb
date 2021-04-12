# frozen_string_literal: true

require_relative 'requirable'

# App
class App
  include Interface

  OPERATIONS = {
    1 => :create_station,
    2 => :create_train,
    3 => :create_route,
    4 => :create_wagon,
    5 => :add_station,
    6 => :remove_station,
    7 => :assign_route,
    8 => :attach_wagon,
    9 => :remove_wagon,
    10 => :move_forward,
    11 => :move_back,
    12 => :show_stations,
    13 => :trains_list,
    14 => :trains_on_stations,
    15 => :wagons_on_trains,
    16 => :select_station,
    17 => :select_train,
    18 => :select_route,
    19 => :select_wagon
  }.freeze

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
    interface
  end

  def show
    INTERFACE.each.with_index(STARTING_INDEX) { |item, i| puts "#{i}. #{item}" }
  end

  def process_input(user_input)
    method = OPERATIONS[user_input.to_i]

    return puts "invalid input" unless method

    send(method)
  end

  private

  TYPE_LIST = %w[Cargo Passenger].freeze
  STARTING_INDEX = 1

  attr_reader :stations, :routes, :trains, :wagons
  attr_accessor :current_station, :current_route, :current_train, :current_wagon

  def create_station
    puts 'Please enter a name of a station'
    name = gets.chomp
    begin
      station = Station.new(name)
    rescue RuntimeError => e
      return puts e
    end
    stations << station
    puts "Station: #{name} was successfully created!!!"
    @current_station = station
  end

  def create_route
    puts 'Please select first and last stations'
    begin
      route = Route.new(select_station, select_station)
    rescue RuntimeError => e
      return puts e
    end
    routes << route
    puts "Route: #{route.name} was successfully created!!!"
    @current_route = route
  end

  def create_wagon
    type = select_type

    wagon = type == 'Cargo' ? create_cargo_wagon : create_passenger_wagon
    wagons << wagon
    puts "#{type} wagon was successfully created!!!"
    @current_wagon = wagon
  end

  def create_passenger_wagon
    puts 'Please enter seats'
    seats = gets.chomp.to_i

    PassengerWagon.new(seats)
  end

  def create_cargo_wagon
    puts 'Please enter volume'
    volume = gets.chomp.to_f

    CargoWagon.new(volume)
  end

  def create_train
    puts "Please enter train's number"
    number = gets.chomp.to_i

    puts "Please enter train's type:"
    type = select_type

    begin
      train =
        if type == 'Cargo'
          CargoTrain.new(number)
        else
          PassengerTrain.new(number)
        end
    rescue RuntimeError => e
      return puts e
    end

    trains << train

    puts "#{type} train, with number: #{number} was successfully created!!!"
    @current_train = train
  end

  def select_type
    TYPE_LIST.each.with_index(STARTING_INDEX) { |t, i| puts "#{i}. #{t}" }
    index = gets.chomp.to_i

    TYPE_LIST[index - 1]
  end

  def add_station
    return puts "error" unless current_station || current_route

    current_route.add_station(current_station)
  end

  def remove_station
    return puts "error" unless current_route || current_station

    current_route.remove_station(current_station)
  end

  def assign_route
    return puts "error" unless current_train || current_route

    current_train.assign_route(current_route)
  end

  def attach_wagon
    return puts "error" unless current_train || current_wagon

    current_train.attach_wagon(current_wagon)
  end

  def remove_wagon
    return puts "error" unless current_train || current_wagon

    current_train.remove_wagon(current_wagon)
  end

  def move_forward
    return puts "error" unless current_train

    current_train.move_forward
  end

  def move_back
    return puts "error" unless current_train

    current_train.move_back
  end

  def show_wagons
    wagons.each.with_index(STARTING_INDEX) do |w, i|
      puts w == current_wagon ? "=> #{i}. #{w.class}" : "   #{i}. #{w.class}"
    end
  end

  def show_routes
    routes.each.with_index(STARTING_INDEX) do |r, i|
      puts r == current_route ? "=> #{i}. #{r.name}" : "   #{i}. #{r.name}"
    end
  end

  def show_trains
    trains.each.with_index(STARTING_INDEX) do |t, i|
      if t == current_train
        puts "=> #{i}. #{t.class}: #{t.number}"
      else
        puts "   #{i}. #{t.class}: #{t.number}"
      end
    end
  end

  def show_stations
    stations.each.with_index(STARTING_INDEX) do |s, i|
      puts s == current_station ? "=> #{i}. #{s.name}" : "   #{i}. #{s.name}"
    end
  end

  def trains_list
    current_station.trains.each.with_index(STARTING_INDEX) do |t, i|
      puts "#{i}. #{t.class}: #{t.number}"
    end
  end

  def empty_message(obj)
    "you need to create at least 1 #{obj} first"
  end

  def select_station
    return puts empty_message('station') if stations.empty?

    puts 'Please select station, as a default one:'
    show_stations
    index = gets.chomp.to_i
    self.current_station = stations[index - 1]
  end

  def select_train
    return puts empty_message('train') if trains.empty?

    puts 'Please select train, as a default one:'
    show_trains

    index = gets.chomp.to_i
    self.current_train = trains[index - 1]
  end

  def select_route
    return puts empty_message('route') if routes.empty?

    puts 'Please selece route as a default one:'
    show_routes

    index = gets.chomp.to_i
    self.current_route = routes[index - 1]
  end

  def select_wagon
    return puts empty_message('wagon') if wagons.empty?

    puts 'Please select wagon as a default one:'
    show_wagons

    index = gets.chomp.to_i
    self.current_wagon = wagons[index - 1]
  end

  def trains_on_stations
    str = lambda { |train|
      puts "#{train.number}, #{train.class}, #{train.wagons.size}"
    }
    stations.each { |station| station.trains_method(str) }
  end

  def wagons_on_trains
    str = proc do |wagon|
      str = if wagon.passenger?(wagon)
              "#{wagon.seats}, #{wagon.taken_seats}"
            else
              "#{wagon.available_volume}, #{wagon.taken_volume}"
            end
      print "0, #{wagon.class}, #{str}"
    end

    trains.each { |train| train.wagons_method(str) }
  end

  def passenger?(wagon)
    wagon.is_a?(PassengerWagon)
  end
end

App.new
