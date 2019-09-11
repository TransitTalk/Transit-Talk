# frozen_string_literal: true

require "application_system_test_case"

class IssueCreationsTest < ApplicationSystemTestCase
  test "visiting the index" do
    sign_in_ui users(:one), password: "password"

    visit line_url(lines(:red_line))

    assert_selector "h3 div", text: "red line (red line)"
  end
end
