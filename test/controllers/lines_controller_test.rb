# lines_controller_test.rb
require 'test_helper'

class LinesControllerTest < ActionDispatch::IntegrationTest

  # Can we get the index page?  
  test "get index page" do
    get lines_url
    lines = assigns(:lines) 
    all_lines = Line.all
    assert_equal all_lines.size, lines.size 
    assert_response :success
  end

  # Simple test to verify we get the show page when we
  # invoke the page with a valid ID
  test "get show page with valid line id" do
    param_line = lines(:one) 
    assert_not_nil param_line

    get line_path(param_line.id) 
    line = assigns(:line)  
    assert_equal param_line.id, line.id
    assert_response :success
  end

  # Simple test to verify we get the show page when we
  # invoke the page with a valid ID
  test "get show page with invalid line id" do
    invalid_line_id = -1
    assert_raises ActiveRecord::RecordNotFound do
      get line_path(invalid_line_id)
    end
  end

end
