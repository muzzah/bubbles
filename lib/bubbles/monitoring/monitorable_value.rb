require "bubbles/monitoring/monitorable"
require "bubbles/monitoring/value_semantics"

module Bubbles
  class MonitorableValue < Monitorable

    def initialize(name, description, initial_value=nil)
      init_properties name, description, ValueSemantics::FREE_RUNNING, initial_value
    end

  end
end