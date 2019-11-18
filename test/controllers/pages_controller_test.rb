# frozen_string_literal: true

require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "shows favorites on home page for logged in user" do
    @user = create :user
    @stop = create :stop, onestop_id: "my-little-favorite"
    @user.favorites << @stop

    sign_in @user

    get root_path

    assert_response :success
    assert_select "#favorites_table" do |table_element|
      assert_select table_element, ".clickable-row", 1
    end
  end

  test "does not render favorites table for logged in user with no favorites" do
    @user = create :user
    create :stop, onestop_id: "test-stop-id"

    sign_in @user

    get root_path

    assert_response :success
    assert_select "#favorites_table", 0
  end
end
