require 'spec_helper'
describe Bubbles::MonitorablesContainer do

  let(:container) {Bubbles::MonitorablesContainer.new}
  let(:monitorable1) {Bubbles::Counter.new("name1", "description1",1)}
  let(:monitorable2) {Bubbles::Counter.new("name2", "description2",2)}
  let(:monitorables) {[monitorable1,monitorable2]}



  it "should throw an error if an already added monitorable is added again" do
    container.add monitorable1
    lambda{ container.add monitorable1 }.should raise_error ArgumentError
  end
  
  it "should return a previously added monitorable" do
    container.add monitorable1
    container["name1"].should be monitorable1
  end
  
  it "should return nil for an unknown metric name" do
    container["lulwat"].should be nil
  end

  it "should allow to iterate over each monitorable" do
    mons = monitorables

    mons.each do |monitorable|
      container.add monitorable
    end

    container.each do |monitorable|
      mons.delete monitorable do
        raise "Came across a monitorable not created by this test"
      end
    end
    mons.size.should be 0

  end

  it "should return an initial size of zero" do
    container.size.should be 0
  end

  it "should return an the correct size after adding 2 monitorables" do
    add_monitorables_to_container
    container.size.should be 2
  end

  it "should clear monitorables that were added" do
    add_monitorables_to_container
    container.clear
    container.size.should be 0
  end

  it "should return a list of monitorables it has in a colleciton that is not referenced by the container" do
    add_monitorables_to_container
    mons = container.monitorables
    mons.clear
    container.monitorables.size.should be 2
    container.monitorables.include?(monitorable1).should be true
    container.monitorables.include?(monitorable2).should be true
  end

  def add_monitorables_to_container
    container.add monitorable1
    container.add monitorable2
  end

end
