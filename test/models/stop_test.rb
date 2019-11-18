# frozen_string_literal: true

require "test_helper"

class StopTest < ActiveSupport::TestCase
  test "#html_safe_id removes ~ from a stop's ID" do
    test_stop = create :stop, onestop_id: "test-stop~id"
    assert_equal("test-stop-id", test_stop.html_safe_id)
  end

  test ".find_nearby gets nearby trains and bus stations" do
    lat, long = [41.892581, -87.631068]
    nearby_stop = create :stop, lattitude: lat, longitude: long, serviced_by: "bus"
    far_away_stop = create :stop, lattitude: lat + 3, longitude: long - 5, serviced_by: "bus"
    nearby_train_stop = create :stop, lattitude: lat, longitude: long, serviced_by: "metro"
    far_away_train_stop = create :stop, lattitude: lat + 3, longitude: long - 5, serviced_by: "metro"

    result = Stop.find_nearby(longitude: long, latitude: lat)
    assert_includes(result['metro'], nearby_train_stop)
    assert_not_includes(result['metro'], far_away_train_stop)
    assert_includes(result['bus'], nearby_stop)
    assert_not_includes(result['bus'], far_away_stop)
  end
end
