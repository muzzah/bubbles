require 'spec_helper'
describe Bubbles::MetricName do

  it "should parse single segment metric names" do
    Bubbles::MetricName.new"sdasd"
  end

  it "should parse single segment metric names beginning with underscore" do
    Bubbles::MetricName.new"__sdasd"
  end

  it "should parse single segment metric names ending with underscore" do
    Bubbles::MetricName.new"sdasd__"
  end

  it "should parse single segment metric names beginning & ending with underscore" do
    Bubbles::MetricName.new"__sdasd__"
  end

  it "should not parse single segment metric names with invalid characters" do
    lambda { Bubbles::MetricName.new"!__s$dasd__" }.should raise_error ArgumentError
  end

  it "should not parse whitespace only strings" do
    lambda { Bubbles::MetricName.new"   " }.should raise_error ArgumentError
  end

  it "should not parse zero length strings" do
    lambda { Bubbles::MetricName.new "" }.should raise_error ArgumentError
  end

  it "should not parse nil strings" do
    lambda { Bubbles::MetricName.new nil }.should raise_error ArgumentError
  end

  it "should not parse single segment metric names with invalid characters" do
    lambda { Bubbles::MetricName.new"!__s$dasd__" }.should raise_error ArgumentError
  end

  it "should allow two segmented metric names" do
    Bubbles::MetricName.new"__sdasd__.a"
  end

  it "should allow two segmented metric names with underscores" do
    Bubbles::MetricName.new"__sdasd__.a__"
  end

  it "should allow 5 segmented metric names" do
    Bubbles::MetricName.new "__sdasd__.a__.h.sdssd.ere"
  end


  it "should not support instances on single segmented metric names" do
    lambda { Bubbles::MetricName.new"__sdasd__[sdf]" }.should raise_error ArgumentError
  end

  it "should not support instances on two segmented metric names" do
    lambda { Bubbles::MetricName.new"__sdasd__.adas[sdf]" }.should raise_error ArgumentError
  end

  it "should return the metric as the metric name" do
    Bubbles::MetricName.new("a.b.c.d").metric.should == "a.b.c.d"
  end

end