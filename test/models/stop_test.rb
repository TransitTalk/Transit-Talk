# frozen_string_literal: true

require "test_helper"

class StopTest < ActiveSupport::TestCase
  test "#html_safe_id removes ~ from a stop's ID" do
    test_stop = stops(:one)
    assert_equal("test-stop-id", test_stop.html_safe_id)
  end
end
