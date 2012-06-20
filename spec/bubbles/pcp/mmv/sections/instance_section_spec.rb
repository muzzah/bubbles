require 'spec_helper'
describe Bubbles::InstanceSection do

  it "should be 80 bytes long" do
    Bubbles::InstanceSection.new.num_bytes.should be 80
  end

end