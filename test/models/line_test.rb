# frozen_string_literal: true

require "test_helper"

class LineTest < ActiveSupport::TestCase
  setup do
    Line.create(name: "RouteShort")
    Line.create(name: "RouteShort", vehicle_type: "bus")
    Line.create(name: "RouteShort", vehicle_type: "train")
    Line.create(name: "RouteShort", system_type: Line::TRAM_SYSTEM_TYPE)
    Line.create(name: "RouteShort", system_type: Line::METRO_SYSTEM_TYPE)
    Line.create(name: "RouteShort", system_type: Line::BUS_SYSTEM_TYPE)
  end

  test "returns proper long name" do
    route_long_name = "RouteLong"
    route_short_name = "RouteShort"
    line = Line.new(route_long_name: route_long_name, name: route_short_name)
    assert_equal route_long_name, line.long_name, "Failed to return correct route long name"
  end

  test "returns proper long name if no long name provided" do
    route_short_name = "RouteShort"
    line = Line.new(name: route_short_name)
    assert_equal route_short_name, line.long_name, "Failed to return correct route long name"
  end

  test "returns proper short name" do
    route_long_name = "RouteLong"
    route_short_name = "RouteShort"
    line = Line.new(route_long_name: route_long_name, name: route_short_name)
    assert_equal route_short_name, line.short_name, "Failed to return correct route short name"
  end

  test "returns proper short name if no short name provided" do
    route_long_name = "RouteLong"
    line = Line.new(route_long_name: route_long_name)
    assert_nil line.short_name, "Failed to return correct route short name"
  end

  test "bus? returns true if system type or vehicle type indicates bus" do
    line = Line.new(vehicle_type: "bus")
    assert line.bus?

    line = Line.new(system_type: Line::BUS_SYSTEM_TYPE)
    assert line.bus?
  end

  test "bus? returns false if system type is not bus type" do
    line = Line.new(system_type: Line::METRO_SYSTEM_TYPE, vehicle_type: "bus")
    assert_not line.bus?
  end

  test "bus? returns false if system type is nil and vehicle type is not bus" do
    line = Line.new(vehicle_type: "tram")
    assert_not line.bus?
  end

  test "train? returns true if system type is tram or metro" do
    line = Line.new(system_type: Line::TRAM_SYSTEM_TYPE)
    assert line.train?

    line = Line.new(system_type: Line::METRO_SYSTEM_TYPE)
    assert line.train?
  end

  test "train? returns true if vehicle type is tram or metro" do
    line = Line.new(vehicle_type: "tram")
    assert line.train?

    line = Line.new(vehicle_type: "metro")
    assert line.train?
  end

  test "train? returns false if system type is not tram or metro" do
    line = Line.new(system_type: Line::BUS_SYSTEM_TYPE, vehicle_type: "tram")
    assert_not line.train?
  end

  test "train? returns false if system type is nil and vehicle type is wrong" do
    line = Line.new(vehicle_type: "bus")
    assert_not line.train?
  end

  test "line with no vehicle or system type is not bus? or train?" do
    line = Line.new
    assert_not line.bus?
    assert_not line.train?
  end

  test "of_line_type(bus) returns all bus lines" do
    lines = Line.of_line_type("bus")
    assert_not lines.empty?
    assert lines.all?(&:bus?)
  end

  test "of_line_type(train) returns all train lines" do
    lines = Line.of_line_type("train")
    assert_not lines.empty?
    assert lines.all?(&:train?)
  end

  test "of_line_type(nil) returns all lines" do
    line_count = Line.count
    lines = Line.of_line_type(nil)
    assert_not lines.empty?
    assert_equal line_count, lines.count
  end
end
