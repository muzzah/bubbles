require 'logger'
require 'bubbles/monitoring/output_bridge'

require 'bubbles/pcp/mmv/mmv_file_writer'

module Bubbles
  class PCPOutputBridge
    include OutputBridge
    MAX_METRICS=1024

    def initialize
      @logger = Logger.new STDOUT
      @mmv_writer = MMVFileWriter.new
      @mutex = Mutex.new
      @monitored_metrics = MonitorablesContainer.new

    end

    def update monitorable
      @logger.info "PCPBridge has been notified that the monitorable '#{monitorable.name}' has changed in value"
      monitored_metric = nil
      access_monitorables do |monitored_metrics|
        if monitored_metrics[monitorable.name].nil?
          @logger.info "Cant find existing metric #{monitorable.name}, silently ignoring"
        else
          monitored_metric = monitored_metrics[monitorable.name]
        end
      end

      @mmv_writer.update monitored_metric

    end

    def added_monitorable monitorable
      @logger.info "PCPBridge has been notified of a monitorable which has been added - #{monitorable.name}"
      convert_monitorable_to_metric monitorable do |metric|
        @logger.info "PCPMetric #{metric} is being added"
        @mmv_writer.add_metric metric
        access_monitorables do |monitored_metrics|
          monitored_metrics[
          ] = metric
        end
      end
    end

    def going_to_start_monitoring
      @logger.info "PCPBridge has been notified that monitoring is about to begin"
    end

    def started_monitoring
      @logger.info "PCPBridge has been notified that monitoring has started"
      @mmv_writer.start
    end

    def going_to_stop_monitoring
      @logger.info "PCPBridge has been notified that monitoring is about to stop"
    end

    def stopped_monitoring
      @logger.info "PCPBridge has been notified that monitoring has stopped"
      @mmv_writer.stop
    end

    private
    def convert_monitorable_to_metric monitorable
      yield PCPMetricInfo.new monitorable,generate_id(monitorable)
    end

    def access_monitorables
      @mutex.synchronize do
        yield @monitored_metrics
      end
    end

    def access_monitorable_by_name name
      monitorable = nil
      @mutex.synchronize do
        monitorable = @monitored_metrics_by_name[name]
      end

      yield monitorable
    end

    def generate_id monitorable
#      id = monitorable.name.hash % MAX_METRICS
#      access_monitorables do |monitored_metrics|
#        while true do
#          if !monitorables[id].nil?
#            id += 1
#          else
#            break;
#          end
#
#        end
#      end
#      id
      monitorable.name.hash
    end

  end
end