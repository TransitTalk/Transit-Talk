# frozen_string_literal: true

# lines_controller_test.rb
require "test_helper"

class StopsControllerTest < ActionDispatch::IntegrationTest
  # Simple test to verify we get the show page when we
  # invoke the page with a valid ID
  test "get show page with valid stop id" do
    param_stop = stops(:one)
    assert_not_nil param_stop

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
end

