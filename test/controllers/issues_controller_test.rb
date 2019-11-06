# frozen_string_literal: true

# issues_controller_test.rb
require "test_helper"

class IssuesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create :user
    @admin = create :user, :admin
    @stop = create :stop, onestop_id: "test-stop-id"
    @line = create :line, stops: [@stop]
    @issue = create :issue, user: @user
  end

  test "logged in should get issues page" do
    # Sign in user
    sign_in @user

    get new_issue_url, params: { stop_id: @stop.id, line_id: @line.id }
    issue = assigns(:issue)
    assert_equal @stop.id, issue.stop_onestop_id
    assert_equal @line.id, issue.line_onestop_id
    assert_response :success
  end

  test "unauthenticated user can create an issue" do
    get new_issue_url, params: { stop_id: @stop.id, line_id: @line.id }

    assert_response :ok
  end

  test "get redirected from issues index if normal user" do
    sign_in @user

    get issues_path
    assert_response :redirect
  end

  test "get index page for issues as admin" do
    sign_in @admin

    get issues_path
    assert_response :success
  end

  test "user can create issue" do
    sign_in @user

    post issues_url params: { issue: {
        stop_onestop_id: @stop.id,
        line_onestop_id: @line.id,
        description: "something",
        types: ["another thing"]
    } }

    assert_response :found
  end

  test "creating issue fails if it does not have type" do
    post issues_url params: { issue: {
        stop_onestop_id: @stop.onestop_id,
        line_onestop_id: @line.id,
        description: "something"
    } }

    assert_response :ok
  end

  test "user can modify issues" do
    sign_in @user
    patch issue_url @issue.id, params: { issue: {
        stop_onestop_id: "2",
        line_onestop_id: "2",
        description: "something",
        types: ["another thing"]
    } }

    assert_response :found
    assert_equal "Issue was successfully updated.", flash[:notice]
  end

  # TODO: We should make sure a user can only delete their issue, unless admin
  test "user can delete an issue" do
    sign_in @user
    delete issue_url @issue.id

    assert_response :found
    assert_equal "Issue was successfully destroyed.", flash[:notice]
  end
end
