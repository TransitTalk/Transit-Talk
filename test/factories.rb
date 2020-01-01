# frozen_string_literal: true

require "securerandom"
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
    stop
  end

  factory :stop do
    name { "stop_name" }
    lattitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    api_id { rand(1..100) }
    twin_stop_id { rand(1..100) }
    onestop_id { SecureRandom.base64(8) }
    serviced_by { LIST_VEHICLE_TYPE.sample }

    after(:create) do |stop|
      lines = create_list(:line, 1, stops: [stop])
      create_list(:issue, 1, stop: stop, line: lines[0])
    end
  end

  factory :line do
    route_long_name { Faker::Address.street_name }
    name { "some_line" }
    system_type { LIST_SYSTEM_TYPES.sample }
    color { LIST_LINE_COLORS.sample }
    onestop_id { Faker::Hipster.word }
    vehicle_type { LIST_VEHICLE_TYPE.sample }
    wheelchair_accessible { LIST_WHEELCHAIR_ACCESSIBLE.sample }
    bikes_allowed { rand(0..BIKES_ALLOWED) }
    stops { [] }
  end
end
