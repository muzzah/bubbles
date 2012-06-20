require "bubbles/utils/enum"

module Bubbles

  module ValueSemantics
  	include Enum
    FREE_RUNNING = 0
    CONSTANT = 1
    INCREASING = 2
  end
end