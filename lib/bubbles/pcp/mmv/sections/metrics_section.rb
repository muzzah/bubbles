require 'bindata'


module Bubbles

  class MetricsSection < BinData::Record
    endian :little
    uint512 :metric_name
    uint32 :metric_item
    uint32 :metric_type
    uint32 :metric_semantics
    uint32 :metric_dimensions
    uint32 :instance_domain_id
    uint32 :zero_padding
    uint64 :short_help_text_offset
    uint64 :long_help_text_offset

  end
end


