# frozen_string_literal: true

Capybara.register_driver :headless_firefox do |app|
    browser_options = Selenium::WebDriver::Firefox::Options.new()
    browser_options.args << "--headless"
    Capybara::Selenium::Driver.new(
      app,
        browser: :firefox,
        options: browser_options
      )
  end

config.include Devise::Test::IntegrationHelpers, type: :feature
