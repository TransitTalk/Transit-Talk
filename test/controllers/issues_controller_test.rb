# frozen_string_literal: true

# issues_controller_test.rb
require "test_helper"

class IssuesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "logged in should get issues page" do
    # Sign in user
    sign_in users(:one)

    get new_issue_url, params: { stop_id: stops(:one).id, line_id: lines(:one).id }
    issue = assigns(:issue)
    assert_equal stops(:one).id, issue.stop_onestop_id
    assert_equal lines(:one).id, issue.line_onestop_id
    assert_response :success
  end

  test "unauthenticated user cannot create an issue" do
    get new_issue_url, params: { stop_id: stops(:one).id, line_id: lines(:one).id }

    assert_response :found
  end

  test "get index page for issues" do
    sign_in users(:one)

    get issues_path
    assert_response :success
  end

  test "user can create issue" do
    sign_in users(:one)

    post issues_url params: {issue:{stop_onestop_id: stops(:one).id, line_onestop_id: lines(:one).id, description: 'something', types: 'another thing'}}

    assert_response :found
  end

  test "creating issue fails if it does not have type" do
    post issues_url params: {issue:{stop_onestop_id: stops(:one).id, line_onestop_id: lines(:one).id, description: 'something'}}

    assert_response :ok
  end

  test "user can modify issues" do
    sign_in users(:one)
    issue = issues(:one)
    patch issue_url issue.id, params: {issue:{stop_onestop_id: "2", line_onestop_id: "2", description: 'something', types: 'another thing'}}

    assert_response :found
    assert_equal "Issue was successfully updated.", flash[:notice]
  end

  # TODO: We should make sure a user can only delete their issue, unless admin
  test "user can delete an issue" do
    sign_in users(:one)
    issue = issues(:one)
    delete issue_url issue.id

    assert_response :found
    assert_equal "Issue was successfully destroyed.", flash[:notice]
  end

end
