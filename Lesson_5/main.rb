# # frozen_string_literal: true

require_relative 'requirable'

# class App
#   def initialize
#     @stations = []
#     @routes = []
#     @trains = []
#     @wagons = []
#     interface
#   end

#   def show
#     %w[
#       Create\ station
#       Create\ train
#       Create\ route
#       Create\ wagon
#       Add\ station\ to\ route
#       Remove\ station\ from\ route
#       Assign\ route\ to\ train
#       Attach\ wagons\ to\ the\ train
#       Remove\ wagons\ from\ the\ train
#       Send\ train\ forward
#       Send\ train\ back
#       Show\ station\ list
#       Show\ trains\ on\ current_station
#       Select\ current\ station
#       Select\ current\ train
#       Select\ current\ route
#       Select\ current\ wagon
#       Exit
#     ].each.with_index(STARTING_INDEX) { |item, i| puts "#{i}. #{item}" }
#   end

#   def interface
#     loop do
#       show
#       users_input = gets.chomp.to_i
#       break if users_input == 18

#       process_input(users_input)
#     end
#   end

#   def process_input(user_input)
#     case user_input
#     when 1
#       create_station
#     when 2
#       create_train
#     when 3
#       create_route
#     when 4
#       create_wagon
#     when 5
#       add_station
#     when 6
#       remove_station
#     when 7
#       assign_route
#     when 8
#       attach_wagon
#     when 9
#       remove_wagon
#     when 10
#       move_forward
#     when 11
#       move_back
#     when 12
#       show_stations
#     when 13
#       trains_list
#     when 14
#       select_station
#     when 15
#       select_train
#     when 16
#       select_route
#     when 17
#       select_wagon
#     else
#       puts 'invalid input...'
#     end
#   end

#   private
  
#   TYPE_LIST = %w[Cargo Passenger].freeze
#   STARTING_INDEX = 1

#   attr_reader :stations, :routes, :trains, :wagons
#   attr_accessor :current_station, :current_route, :current_train, :current_wagon

#   def create_station
#     puts 'Please enter a name of a station'
#     name = gets.chomp
#     station = Station.new(name)
#     stations << station
#     puts "Station: #{name} was successfully created!!!"
#     @current_station = station
#   end

#   def create_route
#     return puts 'There are not enough stations...' if stations.size < 2

#     puts 'Please select first and last stations'
#     route = Route.new(select_station, select_station)
#     routes << route
#     puts "Route: #{route.name} was successfully created!!!"
#     @current_route = route
#   end

#   def create_wagon
#     type = select_type

#     wagon = type == 'Cargo' ? CargoWagon.new : PassengerWagon.new
#     wagons << wagon
#     puts "#{type} wagon was successfully created!!!"
#     @current_wagon = wagon
#   end

#   def create_train
#     puts "Please enter train's number"
#     number = gets.chomp.to_i

#     puts "Please enter train's type:"
#     type = select_type

#     train = type == 'Cargo' ? CargoTrain.new(number) : PassengerTrain.new(number)
#     trains << train

#     puts "#{type} train, with number: #{number} was successfully created!!!"
#     @current_train = train
#   end

#   def select_type
#     TYPE_LIST.each.with_index(STARTING_INDEX) { |t, i| puts "#{i}. #{t}" }
#     index = gets.chomp.to_i

#     TYPE_LIST[index - 1]
#   end

#   def add_station
#     return puts 'error' unless current_station || current_route

#     current_route.add_station(current_station)
#   end

#   def remove_station
#     return puts 'error' unless current_route || current_station

#     current_route.remove_station(current_station)
#   end

#   def assign_route
#     return puts 'error' unless current_train || current_route

#     current_train.assign_route(current_route)
#   end

#   def attach_wagon
#     return puts 'error' unless current_train || current_wagon

#     current_train.attach_wagon(current_wagon)
#   end

#   def remove_wagon
#     return puts 'error' unless current_train || current_wagon

#     current_train.remove_wagon(current_wagon)
#   end

#   def move_forward
#     return puts 'error' unless current_train

#     current_train.move_forward
#   end

#   def move_back
#     return puts 'error' unless current_train

#     current_train.move_back
#   end

#   def show_wagons
#     wagons.each.with_index(STARTING_INDEX) { |w, i| puts w == current_wagon ? "=> #{i}. #{w.class}" : "   #{i}. #{w.class}" }
#   end

#   def show_routes
#     routes.each.with_index(STARTING_INDEX) { |r, i| puts r == current_route ? "=> #{i}. #{r.name}" : "   #{i}. #{r.name}" }
#   end

#   def show_trains
#     trains.each.with_index(STARTING_INDEX) { |t, i| puts t == current_train ? "=> #{i}. #{t.class}: #{t.number}" : "   #{i}. #{t.class}: #{t.number}" }
#   end

#   def show_stations
#     stations.each.with_index(STARTING_INDEX) { |s, i| puts s == current_station ? "=> #{i}. #{s.name}" : "   #{i}. #{s.name}" }
#   end

#   def trains_list
#     current_station.trains.each.with_index(STARTING_INDEX) { |t, i| puts "#{i}. #{t.type}: #{t.number}" }
#   end

#   def empty_message(obj)
#     "you need to create at least 1 #{obj} first"
#   end

#   def select_station 
#     return puts empty_message('station') if stations.empty?

#     puts 'Please select station, as a default one:'
#     show_stations
#     index = gets.chomp.to_i
#     self.current_station = stations[index - 1]
#   end

#   def select_train
#     return puts empty_message('train') if trains.empty?

#     puts 'Please select train, as a default one:'
#     show_trains

#     index = gets.chomp.to_i
#     self.current_train = trains[index - 1]
#   end

#   def select_route
#     return puts empty_message('route') if routes.empty?

#     puts 'Please selece route as a default one:'
#     show_routes

#     index = gets.chomp.to_i
#     self.current_route = routes[index - 1]
#   end

#   def select_wagon
#     return puts empty_message('wagon') if wagons.empty?

#     puts 'Please select wagon as a default one:'
#     show_wagons

#     index = gets.chomp.to_i
#     self.current_wagon = wagons[index - 1]
#   end
# end

# App.new

Station.new('first staiton')
Station.new('last station')
p Station.all

Train.new(12345)
Train.new(67890)
puts Train.find(12345)
puts Train.find(67890)
p Train.find(2314)

50.times { print '-' }

p Station.instances

