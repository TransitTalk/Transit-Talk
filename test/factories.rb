# frozen_string_literal: true

require_relative "../lib/constants"

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    admin { false }

    trait :admin do
      admin { true }
    end
  end

  factory :issue do
    description { Faker::Lorem.paragraph(2, true) }
    types { LIST_ISSUES_TYPES.sample(2) }
    resolved { RANDOM_BOOLEAN.sample }
    user
  end

  factory :stop do
    name { "stop_name" }
    lattitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    api_id { rand(1..100) }
    twin_stop_id { rand(1..100) }
    onestop_id { "onestop_id" }
    serviced_by { %w[bus metro].sample }
    issues { [FactoryBot.create(:issue)] }
  end

  factory :line do
    route_long_name { Faker::Address.street_name }
    name { "some_line" }
    system_type { LIST_SYSTEM_TYPES.sample }
    color { LIST_LINE_COLORS.sample }
    onestop_id { Faker::Hipster.word }
    vehicle_type { Faker::Vehicle.manufacture }
    wheelchair_accessible { LIST_WHEELCHAIR_ACCESSIBLE.sample }
    bikes_allowed { rand(0..BIKES_ALLOWED) }
    stops { [] }
  end
end
