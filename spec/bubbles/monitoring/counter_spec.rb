require 'spec_helper'

describe Bubbles::Counter do
  
  before(:each) do
    @name = "name" 
    @description = "description" 
    @initial_value = 1
    @counter = Bubbles::Counter.new(@name, @description,@initial_value)
  end
  
  it "should return the name it was initialised with" do
    @counter.name.should eql "name"
  end

  it "should return the description it was initialised with" do
    @counter.description.should eql "description"
  end  

  it "should have a semantic value of free running" do
    @counter.value_semantics.should eql Bubbles::ValueSemantics::FREE_RUNNING
  end
  
  it "should return the initial value it was initialised with" do
    @counter.value.should eql 1
  end
  
  it "should increment the value by 1 as default" do
    @counter.value.should eql @initial_value
    @counter.inc
    @counter.value.should eql (@initial_value+1)
  end
  
  it "should increment the value by 3" do
    @counter.value.should eql @initial_value
    @counter.inc 3
    @counter.value.should eql (@initial_value+3)
  end
  
  it "should increment the value by 1 as default" do
    @counter.value.should eql @initial_value
    @counter.dec
    @counter.value.should eql (@initial_value-1)
  end
  
  it "should increment the value by 3" do
    @counter.value.should eql @initial_value
    @counter.dec 3
    @counter.value.should eql (@initial_value-3)
  end
  
end
