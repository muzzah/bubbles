require 'spec_helper'
describe Bubbles::Monitorable do

  it "should throw an exception if attempted to be instantiated" do
    lambda { Monitorable.new }.should raise_error
  end
end
  