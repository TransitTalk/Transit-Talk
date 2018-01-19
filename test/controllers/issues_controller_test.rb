# issues_controller_test.rb
require 'test_helper'

class IssuesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers 

  test "logged in should get issues page" do
    # Sign in user
    sign_in users(:one)

    test_stop_id = "1"
    test_line_id = "1"
    get new_issue_url, params: {stop_id: test_stop_id, line_id: test_line_id}  
    issue = assigns(:issue)
    assert_equal test_stop_id, issue.stop_onestop_id 
    assert_equal test_line_id, issue.line_onestop_id
    assert_response :success
  end
end

