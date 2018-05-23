RANDOM_BOOLEAN = [true, false]

AMOUNT_ISSUES = 50
AMOUNT_LINES = 10
AMOUNT_SETTINGS = 50
AMOUNT_STOPS = 50
AMOUNT_STOPS_USERS = 50
AMOUNT_USERS = 50
AMOUNT_VEHICLES = 50

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
                      "F9461C",
                      "62361c",
                      "109a3a",
                      "e27ea6",
                      "2fa1de",
                      "f9e300",
                      "522397",
                      "c70d30"
                    ]

LIST_WHEELCHAIR_ACCESSIBLE =  ["Elevator", "Ramp"]

BIKES_ALLOWED = 10

puts 'Destroying old issues and seeding fake ones'

Issue.destroy_all

AMOUNT_ISSUES.times do |i|
  Issue.create!(
      stop_onestop_id: "#{i + 1}",
      vehicle_id: i + 1,
      description: Faker::Lorem.paragraph(2, true),
      user_id: rand(1..AMOUNT_USERS),
      line_onestop_id: "#{i + 1}",
      types: LIST_ISSUES_TYPES.sample,
      resolved: RANDOM_BOOLEAN.sample
    )
end

puts 'Destroying old lines and seeding fake ones'

Line.destroy_all
AMOUNT_LINES.times do |i|
  Line.create!(
      route_long_name: Faker::Address.street_address,
      name: Faker::Address.street_name,
      system_type: LIST_SYSTEM_TYPES.sample,
      color: LIST_LINE_COLORS.sample,
      onestop_id: "#{i}",
      vehicle_type: Faker::Vehicle.manufacture,
      wheelchair_accessible: LIST_WHEELCHAIR_ACCESSIBLE.sample,
      bikes_allowed: rand(0..BIKES_ALLOWED)
    )
end

# AMOUNT_SETTINGS.times do |i|
#   Setting.create!(
#       var: "var-#{i}",
#       value: "value-#{i}",
#       thing_id: rand(1..10),
#       thing_type: "thing-type-#{i}"
#     )
# end

puts 'Destroying old stops and seeding fake ones'

Stop.destroy_all
AMOUNT_STOPS.times do |i|
  stop = Stop.create!(
      api_id: "#{i}",
      name: Faker::Address.street_address,
      longitude: Faker::Address.latitude,
      lattitude: Faker::Address.longitude,
      twin_stop_id: i,
      onestop_id: "#{i + 1}"
    )

  # Assign to a line
  stop.lines << Line.find(Line.pluck(:onestop_id).shuffle.first)
end

puts 'Destroying old users and seeding fake ones'

User.destroy_all
AMOUNT_USERS.times do |i|
  User.create!(
      email: Faker::Internet.email,
      password: "cat-dog-#{i}",
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

Stop.all.each.with_index do |stop, i|
  stop.users << User.all[i]
end

Vehicle.destroy_all
AMOUNT_VEHICLES.times do |i|
  Vehicle.create!(
      api_id: "#{i}",
      line_id: rand(1..AMOUNT_LINES)
    )
end
