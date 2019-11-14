# frozen_string_literal: true

require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  test "Clicking split button changes view" do
    visit root_url
    assert page.has_selector?("#type-select")
    assert page.has_selector?("#trains_near")
    assert_not page.has_selector?("#buses_near")
    click_bus_button
    assert_not page.has_selector?("#trains_near")
    assert page.has_selector?("#buses_near")
    assert_selector "h2", text: "Nearby Issues"
  end

  test "Nearby train stations display" do
    visit root_url
    click_train_button
    stops = Stop.all.where(serviced_by: "metro").size
    rows = page.all(:css, ".clickable-row").size
    assert_equal stops, rows
  end

  test "Nearby bus stations display" do
    visit root_url
    click_bus_button
    stops = Stop.all.where(serviced_by: "bus").size
    rows = page.all(:css, ".clickable-row").size
    assert_equal stops, rows
  end

  def click_bus_button
    click_on("buses_near_button")
  end

  def click_train_button
    click_on("trains_near_button")
  end
end
