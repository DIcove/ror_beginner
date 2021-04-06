# frozen_string_literal: true

# Validatable
module Validatable
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  # Validating Station
  module StationValidation
    def validate!
      name_length_error
      name_empty_error
      name_inclusion_error
    end

    private

    def name_length_error
      raise 'invalid length' if name.length < 3 || name.length > 20
    end

    def name_empty_error
      raise "name can't be empty" if name.empty?
    end

    def name_inclusion_error
      raise 'name should include at least one char' if name.split(' ').all? { |char| char =~ /[0-9]/ }
    end
  end

  # Validating Route
  module RouteValidation
    def validate!(first_station, last_station)
      station_inclusion_error(first_station, last_station)
    end

    private

    def station_inclusion_error(first_station, last_station)
      raise 'route can consist only out of stations' unless [first_station, last_station].all? { |station| station.instance_of?(Station) }
    end
  end

  # Validating Train
  module TrainValidation
    def validate!
      number_empty_error
      number_format_error
    end

    private

    def number_empty_error
      raise "number can't be empty" unless number
    end

    def number_format_error
      raise 'invalid format of the number' unless number =~ /[a-z0-9]{3}-?[a-z0-9]{2}/
    end
  end
end
