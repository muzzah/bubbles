require 'bubbles/monitoring/output_bridge'
require 'bubbles/monitoring/monitorable'
require 'bubbles/monitoring/monitorables_container'

module Bubbles
  class MonitoringController

    def initialize opts
      opts = {} if opts.nil?
      raise ArgumentError.new "Output Bridge must extend OutputBridge module to receive monitorable update notifications " if
          !opts[:bridge].class.include?(OutputBridge)
      raise ArgumentError.new "Container must be a monitorables container" if
          opts[:container] && !opts[:container].is_a?(MonitorablesContainer)
      @output_bridge=opts[:bridge]
      @is_running=false
      @container= opts[:container] || MonitorablesContainer.new
    end

    def start_monitoring
      @output_bridge.going_to_start_monitoring
      monitorables_from_object_space do |monitorable|
        @container.add monitorable
        @output_bridge.added_monitorable monitorable
        monitorable.add_observer @output_bridge
      end
      @output_bridge.started_monitoring
      @is_running=true
    end

    def is_not_running?
      !is_running?
    end

    def is_running?
      @is_running
    end

    def monitorables
      @container.monitorables
    end

    def stop_monitoring
      return if is_not_running?
      @output_bridge.going_to_stop_monitoring
      @container.monitorables.each do |monitorable|
        monitorable.delete_observers
      end
      @container.clear
      @output_bridge.stopped_monitoring
      @is_running=false
    end

    private
    def monitorables_from_object_space
      ObjectSpace.each_object(Monitorable) { |mon|
        yield mon
      }
    end

  end
end
