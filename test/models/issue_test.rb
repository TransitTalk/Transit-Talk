require 'test_helper'

class IssueTest < ActiveSupport::TestCase

  # Verify issue is valid if correct fields are provided
  test 'valid issue' do
    issue = Issue.new(issue_type: 'Cleanliness', location_type: 'bus', reported_at: Time.now, stop_onestop_id: '1')
    assert issue.valid?
  end

  # Verify correct errors are raised if an issue is created
  # without the proper fields.
  test 'invalid without location_type, reported_at, or stop_onestop_id' do
    issue = Issue.new(issue_type: 'Cleanliness')
    refute issue.valid?
    assert_not_nil issue.errors[:issue_type]
  end

end

