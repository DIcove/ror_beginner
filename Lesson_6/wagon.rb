# frozen_string_literal: true

require_relative 'manufacturer'

# wagon
class Wagon
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
  end
end
