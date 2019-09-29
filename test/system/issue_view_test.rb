# frozen_string_literal: true

require "application_system_test_case"

class IssuesViewTest < ApplicationSystemTestCase
  test "Clicking split button changes view" do
    visit view_issues_url
    page.has_selector?("#type-select")
    !page.has_selector?("#stops_near")
    page.has_selector?("#lines_near")
    click_on("stops_near_button")
    page.has_selector?("#stops_near")
    !page.has_selector?("#lines_near")
    assert_selector "h2", text: "View Issues"
  end
end
