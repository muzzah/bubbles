require 'spec_helper'
describe Bubbles::MonitoringController do

  let(:output_bridge) {
    bridge_mock = mock
    bridge_mock.define_singleton_method(:update, lambda { |monitorable|})
    bridge_mock
  }

  let(:output_bridge_class) { mock }
  let(:container) { mock }

  let(:monitorables) {
    monitorable_1 = mock
    monitorable_2 = mock
    [monitorable_1, monitorable_2]
  }

  let(:controller) {
    set_bridge_validity_check true
    set_container_check true
    Bubbles::MonitoringController.new(opts)
  }

  context "When initialising a monitoring controller" do
    it "should not accept an output bridge which has not included the Output Bridge module" do
      set_bridge_validity_check false
      lambda { Bubbles::MonitoringController.new({:bridge => output_bridge, :container => container}) }.should raise_error ArgumentError
    end

    it "should not accept a monitorables container which is not of the correct class" do
      set_bridge_validity_check true
      set_container_check false

      lambda {
        Bubbles::MonitoringController.new(opts)
      }.should raise_error ArgumentError
    end

    it "should not accept a nil output bridge" do
      lambda { Bubbles::MonitoringController.new({:container=>container}) }.should raise_error ArgumentError
    end

    it "should initialise a MonitorablesContainer if one is not provided" do
      set_bridge_validity_check true
      Bubbles::MonitorablesContainer.should_receive(:new)
      Bubbles::MonitoringController.new ({:bridge=>output_bridge})
    end

    it "should not accept nil opts" do
      lambda { Bubbles::MonitoringController.new nil }.should raise_error ArgumentError
    end

    it "should accept a valid bridge and container" do
      set_bridge_validity_check true
      set_container_check true
      Bubbles::MonitoringController.new opts
    end


  end

  context "when using an initialised controller with 2 monitorables in memory" do
    before(:each) do
      stub_object_space_with_monitorables
    end

    it "should not be running prior to starting" do
      controller.is_running?.should be false
      controller.is_not_running?.should be true
    end

    it "should not do anything if controller is told to stop" do
      controller.stop_monitoring
    end

    it "should not have any monitorables in the container prior to starting" do
      set_bridge_validity_check true
      Bubbles::MonitoringController.new({:bridge => output_bridge}).monitorables.size.should be 0
    end

    context "then starting the controller" do
      it "should check the object space for monitorables" do
        stub_bridge_start_notifications
        stub_container_add
        stub_monitorables_add_observer_to monitorables
        ObjectSpace.should_receive(:each_object).with(Bubbles::Monitorable).and_yield(monitorables[0]).and_yield(monitorables[1])
        controller.start_monitoring
      end

      it "should notify the bridge when adding a monitorable" do
        stub_container_add
        stub_monitorables_add_observer_to monitorables
        stub_bridge_start_notifications
        output_bridge.should_receive(:added_monitorable).with(monitorables[0])
        output_bridge.should_receive(:added_monitorable).with(monitorables[1])
        controller.start_monitoring
      end

      it "should add the bridge as an observer to the monitorables" do
        stub_bridge_start_notifications
        stub_container_add
        monitorables.each do |monitorable|
          monitorable.should_receive(:add_observer).with(output_bridge)
        end
        controller.start_monitoring
      end

      it "should add both monitorables from object space to the container" do
        stub_bridge_start_notifications
        stub_monitorables_add_observer_to monitorables
        container.should_receive(:add).with(monitorables[0])
        container.should_receive(:add).with(monitorables[1])
        controller.start_monitoring
      end

      it "should notify the bridge when it is going to and has started" do
        output_bridge.should_receive(:going_to_start_monitoring).ordered
        ordered_stub_object_space_with_monitorable
        ordered_stub_container_add
        output_bridge.stub!(:added_monitorable).ordered
        stub_monitorables_add_observer_to [monitorables[0]]
        output_bridge.should_receive(:started_monitoring).ordered
        controller.start_monitoring
      end
    end

  end

  context "when using a started controller with 2 monitorables being monitored" do

    before(:each) do
      stub_object_space_with_monitorables
      stub_container_add
      stub_monitorables_add_observer_to monitorables
      stub_bridge_start_notifications
      controller.start_monitoring
    end

    it "should say its running after starting" do
      controller.is_running?.should be true
      controller.is_not_running?.should be false
    end

    context "then stopping it" do

      it "should remove all observers from monitorables" do
        stub_bridge_stop_notifications
        stub_container_clear
        container.should_receive(:monitorables).and_return(monitorables)
        monitorables.each do |monitorable|
          monitorable.should_receive(:delete_observers)
        end

        controller.stop_monitoring
      end

      it "should notify the bridge when it is about to stop and has stopped" do
        output_bridge.should_receive(:going_to_stop_monitoring).ordered
        container.should_receive(:monitorables).ordered.and_return([])
        container.stub!(:clear).ordered
        output_bridge.should_receive(:stopped_monitoring).ordered
        controller.stop_monitoring
      end

      it "should clear the monitorables it has from the container" do
        stub_bridge_stop_notifications
        container.stub!(:monitorables).ordered.and_return([])
        container.should_receive(:clear)

        controller.stop_monitoring
      end

      it "should say it is not running after being stopped" do
        stub_bridge_stop_notifications
        stub_container_clear
        container.stub!(:monitorables).ordered.and_return([])
        controller.stop_monitoring

        controller.is_running?.should be false
        controller.is_not_running?.should be true
      end

    end
  end

  def stub_container_clear
    container.stub!(:clear)
  end


  def set_bridge_validity_check valid
    output_bridge.should_receive(:class).and_return(output_bridge_class)
    output_bridge_class.should_receive(:include?).with(Bubbles::OutputBridge).and_return(valid)
  end

  def set_container_check valid
    container.should_receive(:is_a?).with(Bubbles::MonitorablesContainer).and_return(valid)
  end

  def opts
    {:bridge => output_bridge, :container => container}
  end

  def stub_object_space_with_monitorables
    ObjectSpace.stub!(:each_object).and_yield(monitorables[0]).and_yield(monitorables[1])
  end

  def ordered_stub_object_space_with_monitorable
    ObjectSpace.stub!(:each_object).and_yield(monitorables[0]).ordered
  end

  def stub_bridge_start_notifications
    output_bridge.stub!(:going_to_start_monitoring)
    output_bridge.stub!(:added_monitorable)
    output_bridge.stub!(:started_monitoring)
  end

  def stub_bridge_stop_notifications
    output_bridge.stub!(:going_to_stop_monitoring)
    output_bridge.stub!(:stopped_monitoring)
  end

  def stub_container_add
    container.stub!(:add)
  end

  def ordered_stub_container_add
    container.stub!(:add).ordered
  end

  def stub_monitorables_add_observer_to mons
    mons.each do |monitorable|
      monitorable.stub!(:add_observer)
    end
  end

end