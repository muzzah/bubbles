

module Bubbles
  module OutputBridge
    def update monitorable
      raise "Must be implemented in a class"
    end

    def going_to_start_monitoring
      raise "Must be implemented in a class"
    end

    def started_monitoring
      raise "Must be implemented in a class"
    end

    def going_to_stop_monitoring
      raise "Must be implemented in a class"
    end

    def stopped_monitoring
      raise "Must be implemented in a class"
    end

    def added_monitorable monitorable
      raise "Must be implemented in a class"
    end

  end
end