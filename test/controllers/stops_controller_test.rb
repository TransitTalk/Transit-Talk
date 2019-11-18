# frozen_string_literal: true

# lines_controller_test.rb
require "test_helper"

class StopsControllerTest < ActionDispatch::IntegrationTest
  # Simple test to verify we get the show page when we
  # invoke the page with a valid ID
  test "get show page with valid stop id" do
    param_stop = create :stop

    get stop_path(param_stop.id)
    stop = assigns(:stop)
    assert_equal param_stop.id, stop.id
    assert_response :success
  end

  # Test to see if invoking the stop show method with an invalid
  # ID prodcues the expected result
  test "get show page with invalid stop id" do
    invalid_stop_id = -1
    assert_raises ActiveRecord::RecordNotFound do
      get stop_path(invalid_stop_id)
    end
  end

  test "get nearby stops" do
    lat, long = [41.892581, -87.631068]
    create :stop, lattitude: lat, longitude: long, serviced_by: "bus"

    get "#{nearby_stops_path}?longitude=#{long}&latitude=#{lat}"
    assert_response :success
    assert_equal(JSON.parse(@response.body)["bus"].length, 1)
  end
end
