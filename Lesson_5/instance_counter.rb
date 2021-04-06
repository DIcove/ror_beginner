# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    @@instances = 0
    attr_accessor :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end

# class Car
#   @instances = 0

#   class << self
#     attr_accessor :instances
#   end
  
#   def initialize
#     register_instance
#   end

#   def register_instance
#     self.class.instances += 1
#   end
# end
