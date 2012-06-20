require 'bindata'
require 'bubbles/pcp/mmv/table_of_content_types'

module Bubbles

  class TableOfContents < BinData::Record
    endian :little
    uint32 :toc_type
    uint32 :no_of_entries
    uint64 :offset_from_beginning

    def self.metrics_with opts={}
      opts.merge({:toc_type => TableOfContentTypes::METRICS})
      TableOfContents.new(opts)
    end
  end
    
  
end
