require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  #setup do
    #@favorite = favorites(:one)
  #end

  test "logged in user should get the favorites page" do
    # Sign in user
    sign_in users(:one)

    get favorites_url
    assert_response :success
  end

  test "unauth user is redirected to log in " do
    get favorites_url
    assert_redirected_to new_user_session_path
  end

  test "creating a new favorite will increase the count by one" do
    # Create user
    user = users(:one)

    # Create a Stop model
    @stop = Stop.create(
      :api_id       => "test_id",
      :name         => "Test Stop",
      :longitude    => 100,
      :lattitude    => 100,
      :twin_stop_id => 1,
      :onestop_id   => "test"
    )

    # Sign in user
    sign_in user

    # Assert that when the GET request happens
    # the current user's favorites count is not the same
    # as when it started the request
    assert_difference 'user.favorites.count' do
      get "/favorite/#{@stop.id}", format: 'json'
    end
    assert_response 201
  end

  test "creating a new favorite will decrease the count by one" do
    # Create user
    user = users(:one)

    # Create a Stop model
    @stop = Stop.create(
      :api_id       => "test_id",
      :name         => "Test Stop",
      :longitude    => 100,
      :lattitude    => 100,
      :twin_stop_id => 1,
      :onestop_id   => "test"
    )

    # Sign in user
    sign_in user

    get "/favorite/#{@stop.id}"

    # Assert that when the GET request happens
    # the current user's favorites count is not the same
    # as when it started the request
    assert_difference 'user.favorites.count', -1 do
      get "/unfavorite/#{@stop.id}", format: 'json'
    end
    assert_response 204
  end

end
