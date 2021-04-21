# frozen_string_literal: true

# Instance counter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # class methods
  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  # instance methods
  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
