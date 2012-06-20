

module Bubbles
  class PCPMetricInfo
    attr_accessor :metricName,
                  :id,
                  :typeHandler,
                  :shortHelpText,
                  :longHelpText,
                  :unit,
                  :semantics

    def initialize monitorable, id
      metric_name=MetricName.new monitorable.name
      id=id
      typeHandler=TypeHandler.get_type_handler_for monitorable.value
      unit = monitorable.unit
      semantics=Semantics.get_semantics_for monitorable.value_semantics
    end

    def to_s
      inspect
    end

  end
end