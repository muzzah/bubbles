require 'spec_helper'
describe Bubbles::Header do
  
  before(:each) do
    @header = Bubbles::Header.new
  end
   context "Default Header" do
    it "should have a tag length of 4 bytes" do
      @header.tag.num_bytes.should eql 4
    end
  
    it "should have tag value 'MMV'" do
      @header.tag.value.should eql "MMV"
    end
    
    it "should have tag binary value 'MMV\\x00'" do
      @header.tag.to_binary_s.should eql "MMV\0"
    end
  
    it "should have a version length of 4 bytes" do
      @header.version.num_bytes.should eql 4
    end
  
    it "should have a version value of 1" do
      @header.version.value.should eql 1
    end
  
    it "should have a generation one length of 8 bytes" do
      @header.generation_1.num_bytes.should eql 8
    end
  
    it "should have a generation one value of 0" do
      @header.generation_1.value.should eql 0
    end
  
    it "should have a generation one length of 8 bytes" do
      @header.generation_2.num_bytes.should eql 8
    end
  
    it "should have a generation two value of 0" do
      @header.generation_2.value.should eql 0
    end
  
    it "should have a toc entries length of 4 bytes" do
      @header.no_of_toc_entries.num_bytes.should eql 4
    end
  
    it "should have a toc entries value of 0" do
      @header.no_of_toc_entries.value.should eql 0
    end
  
    it "should have a flag length of 4 bytes" do
      @header.flags.num_bytes.should eql 4
    end
  
    it "should have a flag value of 0" do
      @header.flags.value.should eql 0
    end
  
    it "should have a pid length of 4 bytes" do
      @header.pid.num_bytes.should eql 4
    end
  
    it "should have a pid value of 0" do
      @header.pid.value.should eql 0
    end
  
    it "should have a cluster identifier of 4 bytes" do
      @header.cluster_identifier.num_bytes.should eql 4
    end

    it "should have a cluster identifier value of 0" do
      @header.cluster_identifier.value.should eql 0
    end
    
    it "should have a total length of 40 bytes" do
      @header.num_bytes.should eql 40
    end
  end
  
end