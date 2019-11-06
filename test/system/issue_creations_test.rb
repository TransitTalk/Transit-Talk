# frozen_string_literal: true

require "application_system_test_case"

class IssueCreationsTest < ApplicationSystemTestCase
  setup do
    @user = create :user
    @admin = create :user, :admin
    @stop = create :stop, onestop_id: "test-stop-id"
    @line = create :line, stops: [@stop]
    @issue = create :issue, user: @user
  end

  test "Creating a train issue is titled 'Report Train Issue'" do
    sign_in_ui @user

    visit line_url(@line)
    visit find("#create-issue-#{@stop.id}")['href']

    assert_selector "h1", text: "Report Train Issue"
  end
end
