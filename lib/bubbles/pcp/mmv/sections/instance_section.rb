require 'bindata'


module Bubbles

  class InstanceSection < BinData::Record
    endian :little
    uint64 :offset_into_indom_section
    uint32 :zero_padding
    uint32 :internal_instance_identifier
    uint512 :external_instance_identifier

  end
end


