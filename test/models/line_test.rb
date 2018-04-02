# frozen_string_literal: true

require "test_helper"

class LineTest < ActiveSupport::TestCase
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
end

