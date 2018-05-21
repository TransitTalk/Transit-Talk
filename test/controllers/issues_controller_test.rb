# frozen_string_literal: true

# issues_controller_test.rb
require "test_helper"

class IssuesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "logged in should get issues page" do
    # Sign in user
    sign_in users(:one)

    test_stop_id = "1"
    test_line_id = "1"
    get new_issue_url, params: { stop_id: test_stop_id, line_id: test_line_id }
    issue = assigns(:issue)
    assert_equal test_stop_id, issue.stop_onestop_id
    assert_equal test_line_id, issue.line_onestop_id
    assert_response :success
  end

  test "does not allow for visitor to create issue" do
    test_stop_id = "1"
    test_line_id = "1"
    get new_issue_url, params: { stop_id: test_stop_id, line_id: test_line_id }

    assert_response :found
  end

  test "get index page for issues" do
    sign_in users(:one)

    get issues_path
    assert_response :success
  end

  test "post create issues" do
    sign_in users(:one)

    test_stop_id = "1"
    test_line_id = "1"
    post issues_url params: {issue:{stop_onestop_id: test_stop_id, line_onestop_id: test_line_id, description: 'something', types: 'another thing'}}

    assert_response :found
  end

  test "post fails if issue does not have type" do
    test_stop_id = "1"
    test_line_id = "1"
    post issues_url params: {issue:{stop_onestop_id: test_stop_id, line_onestop_id: test_line_id, description: 'something'}}

    assert_response :ok
  end

  test "patch issues" do
    sign_in users(:one)
    issue = issues(:one)
    patch issue_url issue.id, params: {issue:{stop_onestop_id: "2", line_onestop_id: "2", description: 'something', types: 'another thing'}}

    assert_response :found
    assert_equal "Issue was successfully updated.", flash[:notice]
  end

  test "delete issues" do
    sign_in users(:one)
    issue = issues(:one)
    delete issue_url issue.id

    assert_response :found
    assert_equal "Issue was successfully destroyed.", flash[:notice]
  end


end
