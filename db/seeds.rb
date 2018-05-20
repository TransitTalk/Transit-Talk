# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
RANDOM_BOOLEAN = [true, false]

AMOUNT_ISSUES = 1000
AMOUNT_LINES = 1000
AMOUNT_SETTINGS = 1000
AMOUNT_STOPS = 1000
AMOUNT_STOPS_USERS = 1000
AMOUNT_USERS = 1000
AMOUNT_VEHICLES = 1000

# LIST_API_ID = ["line_onestop_id","stop_onestop_id"]

LIST_ISSUES_TYPES = [
                      "Delays",
                      "Cleanliness",
                      "Safety",
                      "Crowding",
                      "Accessibility",
                      "Staff",
                      "Other"
                    ]

LIST_SYSTEM_TYPES = [1,2,3,4]

LIST_LINE_COLORS =  [
                      "Orange Line",
                      "Brown Line",
                      "Green Line",
                      "Pink Line",
                      "Blue Line",
                      "Yellow Line",
                      "Purple Line",
                      "Red Line"
                    ]

LIST_WHEELCHAIR_ACCESSIBLE =  ["Elevator", "Ramp"]

BIKES_ALLOWED = 10

AMOUNT_ISSUES.times do
  Issue.create!(
      # stop_onestop_id: ?,
      # vehicle_id: ?,
      description: Faker::Lorem.paragraph(2, true),
      user_id: rand(1..AMOUNT_USERS),
      # line_onestop_id: ?,
      types: LIST_ISSUES_TYPES.sample,
      resolved: RANDOM_BOOLEAN.sample
    )
end

AMOUNT_LINES.times do
  Line.create!(
      route_long_name: Faker::Address.street_address,
      name: Faker::Address.street_name,
      system_type: LIST_SYSTEM_TYPES.sample,
      color: LIST_LINE_COLORS.sample,
      # onestop_id: ?,
      vehicle_type: Faker::Vehicle.manufacture,
      wheelchair_accessible: LIST_WHEELCHAIR_ACCESSIBLE.sample,
      bikes_allowed: rand(0..BIKES_ALLOWED)
    )
end

AMOUNT_SETTINGS.times do
  Setting.create!(
      var: Faker::Lorem.word,
      value: Faker::Lorem.word,
      thing_id: rand(1..10),
      thing_type: Faker::Lorem.word
    )
end

AMOUNT_STOPS.times do
  Stop.create!(
      # api_id: ?,
      name: Faker::Address.street_address,
      longitude: Faker::Address.latitude,
      lattitude: Faker::Address.longitude,
      # twin_stop_id: ?,
      # onestop_id: ?
    )
end

AMOUNT_STOPS_USERS.times do
  StopUser.create!(
      user_id: rand(1..AMOUNT_USERS),
      stop_onestop_id: rand(1..AMOUNT_STOPS)
    )
end

AMOUNT_USERS.times do
  User.create!(
      email: Faker::Internet.email,
      # encrypted_password: ?,
      # reset_password_token: ?,
      # reset_password_sent_at: ?,
      remember_created_at: Faker::Time.between(20.days.ago, Date.today, :all),
      sign_in_count: rand(1..10),
      current_sign_in_at: Faker::Time.between(1.days.ago, Date.today, :all),
      last_sign_in_at: Faker::Time.between(1.days.ago, Date.today, :all),
      current_sign_in_ip: Faker::Internet.ip_v4_address,
      last_sign_in_ip: Faker::Internet.ip_v6_address
    )
end

AMOUNT_VEHICLES.times do
  User.create!(
      # api_id: ?,
      line_id: rand(1..AMOUNT_LINES)
    )
end
