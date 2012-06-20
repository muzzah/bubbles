module Enum
  module ClassMethods
	def is_acceptable_value given_value
      self.constants.index do |constant|
        self.const_get(constant) == given_value
      end
    end
  end
  extend ClassMethods
  def self.included( other )
    other.extend( ClassMethods )
  end

    

end
