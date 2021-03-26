# frozen_string_literal: true

# require_relative 'requirable'

# # some methods test (not essential to read)

# cargo_train = Train.new(12345, 'cargo', 4)

# first_station = Station.new('33rd Street')
# second_station = Station.new('34th Street–Herald Square**')
# third_station = Station.new('163 Street, Amsterdam Ave (Bronx, C Line)')

# route = Route.new(first_station, second_station)
# cargo_train.add_route(route)

# p first_station.trains
# 1000.times { print '=' }
# p first_station.cargo_trains
# p first_station.passenger_trains

# route.add_station(third_station)
# p route.stations

# cargo_train.move_forward
# 1000.times { print '=' }
# p first_station.trains
# 1000.times { print '=' }
# p third_station.trains

# 200.times { print '=' }
# p route.remove_station(first_station)

# route.remove_station(third_station)

# route.stations.each { |s| puts s.name }
