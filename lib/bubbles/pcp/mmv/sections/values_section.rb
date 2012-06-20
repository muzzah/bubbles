require 'bindata'


module Bubbles

  class ValuesSection < BinData::Record
    endian :little
    uint64 :pm_atom_value
    uint64 :extra_space
    uint64 :offset_into_metrics_section
    uint64 :offset_into_instances_section

  end
end


