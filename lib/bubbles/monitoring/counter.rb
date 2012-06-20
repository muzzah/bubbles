require "bubbles/monitoring/monitorable"
require "bubbles/monitoring/value_semantics"

module Bubbles
  class Counter < Monitorable

    def initialize(name, description, initial_value = 0)
      init_properties name, description, ValueSemantics::FREE_RUNNING, initial_value
    end

    def inc(amount = 1)
      change_monitored_value do |current_value|
        current_value+amount
      end
    end

    def dec(amount = 1)
      change_monitored_value do |current_value|
        current_value-amount
      end
    end

  end
end