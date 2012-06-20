require 'bindata'

module Bubbles

  class Header < BinData::Record
    endian :little
    stringz :tag, :length => 4, :value => "MMV\0"
    uint32 :version, :value => 1
    uint64 :generation_1
    uint64 :generation_2
    uint32 :no_of_toc_entries
    bit32 :flags
    uint32 :pid
    uint32 :cluster_identifier
  end
    
  
end
