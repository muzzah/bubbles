require 'spec_helper'
describe Bubbles::Monitorable do

  before(:each) do
    @name = "orly"
    @description = "yahrly"
    @initial_value = 1
    @monitorable = monitorable
    @observer = mock
    @observer.define_singleton_method(:update, lambda { |monitorable|  })
  end

  it "should return an initial value of nil" do
    monitorable(@name, @description, nil).value.should be nil
  end

  it "should return the initial value as provided" do
    @monitorable.value.should be @initial_value
  end

  it "should return the value set using block method" do
    new_value = 10
    @monitorable.change_monitored_value do |current_value|
      new_value
    end

    @monitorable.value.should be new_value
  end

  it "should return the value set using the operator method" do
    new_value = 4
    @monitorable.value=new_value

    @monitorable.value.should be new_value
  end

  it "should notify the observer when the value changes using the block method" do
    @monitorable.add_observer(@observer)
    @observer.should_receive(:update)
    @monitorable.change_monitored_value do |current_value|
      3
    end
  end

  it "should notify the observer when the value changes using the operator method" do
    @monitorable.add_observer(@observer)
    @observer.should_receive(:update)
    @monitorable.value=3
  end

  it "should pass the monitorable itself as the argument to the observers update method when using the operator method" do
    @monitorable.add_observer(@observer)
    @observer.should_receive(:update).with(@monitorable)
    @monitorable.value=3
  end

  it "should pass the monitorable itself as the argument to the observers update method when using the operator method" do
    @monitorable.add_observer(@observer)
    @observer.should_receive(:update).with(@monitorable)
    @monitorable.change_monitored_value do |current_value|
      3
    end
  end

  def monitorable name=@name, description=@description, initial_value=@initial_value
    Bubbles::MonitorableValue.new(name, description, initial_value)
  end

end