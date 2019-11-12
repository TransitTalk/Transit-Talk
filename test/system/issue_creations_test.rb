# frozen_string_literal: true

require "pry"
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
    visit find("#create-issue-#{@stop.id}")["href"]

    assert_selector "h1", text: "Report Train Issue"
  end

  test "user is redirected to stop after submitting issue" do
    visit stop_url(@stop)

    click_on "create-issue-#{@stop.id}"

    page.all(".checkbox-container")[1].click
    fill_in("issue_description", with: "I'm in danger!")

    click_on "Create Issue"

    assert_current_path stop_path(@stop)
  end
end