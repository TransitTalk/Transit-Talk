# frozen_string_literal: true

require "application_system_test_case"

class IssueCreationsTest < ApplicationSystemTestCase
  test "visiting the index" do
    sign_in_ui users(:one), password: "password"

    visit line_url(lines(:red_line))
    find("#create-issue-#{stops(:fullerton).id}").click

    assert_selector "h1", text: "Report Train Issue"
  end
end
