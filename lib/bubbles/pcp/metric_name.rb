

module Bubbles
  class MetricName
    VALID_SEGMENT_PATTERN=/^\w+$/
    attr_reader :metric

    def initialize metric_name
      validate metric_name
      @metric = metric_name
    end

    private
    def validate metric_name
      raise ArgumentError.new"Must provide a non blank metric_name" if metric_name.nil? || metric_name.strip.length==0
      sections = metric_name.split(".")
      sections.each do |segment|
        raise ArgumentError.new "Invalid metric name provided, must not contain instances, not supported" unless
            segment=~VALID_SEGMENT_PATTERN
      end
    end
  end
end