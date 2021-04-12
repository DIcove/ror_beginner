# frozen_string_literal: true

# Instance counter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # class methods
  module ClassMethods
    attr_accessor :instances
  end

  # instance methods
  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
