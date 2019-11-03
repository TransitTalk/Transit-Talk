# frozen_string_literal: true

# Add Coveralls
require "simplecov"
require "coveralls"
Coveralls.wear!

SimpleCov.start do
  add_filter "/test/"
  add_filter "/config/"
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...

  def sign_in(user:, password:)
    post user_session_path \
      "user[email]"    => user.email,
      "user[password]" => password
  end

  # Visits the web app sign in page and logs in using a user fixture and password
  #
  # Use this rather than sign_in for system tests, as they cannot make direct
  # requests via POST
  def sign_in_ui(user_fixture, password:)
    visit user_session_url

    fill_in 'user_email', with: user_fixture.email
    fill_in 'user_password', with: password

    click_on 'Log in'
  end
end
