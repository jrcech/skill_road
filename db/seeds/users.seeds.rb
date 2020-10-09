# frozen_string_literal: true

puts 'Seeding Users'

15.times do |i|
  attrs = {
    password: Faker::Internet.password(min_length: 8, max_length: 32),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    confirmed_at: DateTime.now,
    confirmation_token: Faker::Internet.password(min_length: 20, max_length: 50)
  }

  seed User, { email: "user.#{i}@example.com" }, attrs
end

puts
