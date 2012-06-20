require 'spec_helper'
describe Bubbles::MetricsSection do

  it "should be 104 bytes long" do
    Bubbles::MetricsSection.new.num_bytes.should be 104
  end

end