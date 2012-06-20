require 'spec_helper'
describe "Enum" do
  module MyEnum
    include Enum
    
    CONST_1 = 1
    CONST_2 = 2
    CONST_3 = 3
  end
  
  it "should return true for an acceptable value" do
    MyEnum.is_acceptable_value(MyEnum::CONST_1).should be_true
  end
  
  it "should return false for an acceptable value" do
    MyEnum.is_acceptable_value(4).should be_false
  end
     
  
end
