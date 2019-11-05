# frozen_string_literal: true

# favorites_controller_test.rb
require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create :user
    @test_stop = create :stop, onestop_id: "test-stop-id"
  end

  test "index action redirects to new_user_session_path if no user is signed in" do
    get("/favorites")
    assert_redirected_to(new_user_session_path)
  end

  test "favorites new endpoint adds a clicked stop to a user's favorites" do
    sign_in(@user)
    get("/favorite/#{@test_stop.id}", xhr: true)

    assert_response(:success)
    assert_includes(@user.favorites, @test_stop)
  end

  test "favorites new redirects to new_user_session_path if no user is signed in" do
    get("/favorite/#{@test_stop.id}", xhr: true)
    assert_redirected_to(new_user_session_path)
  end

  test "favorites delete endpoint removes a clicked stop from a user's favorites" do
    sign_in(@user)
    @user.favorites << @test_stop
    assert_not_empty(@user.favorites)

    get("/unfavorite/#{@test_stop.id}", xhr: true)

    assert_response(:success)
    assert_empty(@user.favorites)
  end

  test "favorites delete redirects to new_user_session_path if no user is signed in" do
    get("/unfavorite/#{@test_stop.id}", xhr: true)
    assert_redirected_to(new_user_session_path)
  end
end
