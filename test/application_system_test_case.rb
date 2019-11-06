require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def self.get_browser
    if ENV["SHOW_SYSTEM_TEST_OUTPUT"].present?
      :firefox
    else
      :headless_firefox      
    end
  end

  driven_by :selenium, using: get_browser(), screen_size: [1400, 1400]
end
