# frozen_string_literal: true

require "application_system_test_case"

class IssuesViewTest < ApplicationSystemTestCase
  test "Clicking split button changes view" do
    visit view_issues_url
    assert page.has_selector?("#type-select")
    assert !page.has_selector?("#stops_near")
    assert page.has_selector?("#lines_near")
    click_stops_button
    assert page.has_selector?("#stops_near")
    assert !page.has_selector?("#lines_near")
    assert_selector "h2", text: "View Issues"
  end

  test "Lines display" do
    visit view_issues_url
    click_lines_button
    lines = Line.all.size
    rows = page.all(:css, '.clickable-row').size
    assert_equal lines, rows
  end

  test "Stations display" do
    visit view_issues_url
    click_stops_button
    stops = Stop.all.size
    rows = page.all(:css, '.clickable-row').size
    assert_equal stops, rows
  end

  test "Back button works" do
    visit view_issues_url
    click_back_button
    assert_equal root_path, page.current_path 
  end


  def click_stops_button()
    click_on("stops_near_button")
  end

  def click_lines_button()
    click_on("lines_near_button")
  end

  def click_back_button()
    click_on("back")
  end
end
