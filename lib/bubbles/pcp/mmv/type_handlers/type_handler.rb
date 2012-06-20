

module Bubbles
  module TypeHandler
    MAPPINGS = {
        Fixnum.class => lambda{ |value, record|  record.value = value       },
        Bignum.class => lambda{ |value, record|  record.value = value       },
        TrueClass => lambda { |value, record| record.value = 1},
        FalseClass => lambda { |value, record| record.value = 0}
    }

    def self.get_type_handler_for clazz
      raise "Cant find mapper for #{clazz} class" if MAPPINGS[clazz].nil?
      MAPPINGS[clazz]
    end
  end
end