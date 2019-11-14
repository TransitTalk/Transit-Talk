# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def self.browser
    return :firefox if ENV["SHOW_SYSTEM_TEST_OUTPUT"].present?

    :headless_firefox
  end

  driven_by :selenium, using: browser, screen_size: [1400, 1400]
end
