# frozen_string_literal: true

require "test_helper"

class IssueTest < ActiveSupport::TestCase
  # Verify issue is valid if correct fields are provided
  test "valid issue" do
    issue = build :issue, types: ["Cleanliness"]
    assert issue.valid?
  end

  # Verify correct errors are raised if an issue is created
  # without the proper fields.
  test "invalid without types" do
    line = create :line
    issue = build :issue, line: line, types: nil
    assert_not issue.valid?
    assert_not_nil issue.errors[:types]
  end
end
