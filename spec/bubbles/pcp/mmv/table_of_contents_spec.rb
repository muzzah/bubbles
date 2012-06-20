require 'spec_helper'
describe Bubbles::TableOfContents do

  it "should have a total length of 16 bytes" do
    Bubbles::TableOfContents.new.num_bytes.should be 16
  end
end