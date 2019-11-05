# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    create :user, email: "badperson@gmail.com",
                password: "reallysecure"
  end

  test "banning user bans correct user" do
    user = User.find_by_email("badperson@gmail.com")
    assert_not user.is_banned

    User.ban_user!("badperson@gmail.com")

    user.reload
    assert user.is_banned
  end

  test "banning ignores bad email and does not throw error" do
    User.ban_user!("notauser@gmail.com")
    User.ban_user!("")
  end
end
