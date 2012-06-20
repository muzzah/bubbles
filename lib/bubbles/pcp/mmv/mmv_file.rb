require 'bindata'
require 'bubbles/pcp/mmv/header'
require 'bubbles/pcp/mmv/table_of_contents'

module Bubbles
  class MMVFile < BinData::Record
    header :header
    array :tocs, :type => :table_of_contents
    array :sections, :type => :header
  end
end
