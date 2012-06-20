require "bubbles/utils/enum"
require "bubbles/monitoring/value_semantics"

module Bubbles

  module Semantics
  
    NO_SEMANTICS = 0
    COUNTER = 1
    INSTANT = 3
    DISCRETE = 4

MAPPINGS={
      ValueSemantics::FREE_RUNNING => Semantics::INSTANT,
      ValueSemantics::CONSTANT => Semantics::DISCRETE,
      ValueSemantics::INCREASING => Semantics::COUNTER
    }
    
    def get_semantics_for valueSemantic
      return ValueSemantics::NO_SEMANTICS if MAPPINGS[valueSemantic].nil?
      MAPPINGS[valueSemantic]
    end
  end

end