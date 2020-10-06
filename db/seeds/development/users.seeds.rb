# frozen_string_literal: true

puts 'Seeding Users'

20.times do |i|
  attrs = {
    password: '123456789',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.username,
    confirmed_at: DateTime.now,
    confirmation_token: 'Auto Confirmed'
  }

  seed User, { email: "user.#{i}@example.com" }, attrs
end

puts
