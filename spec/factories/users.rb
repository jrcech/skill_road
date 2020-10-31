# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  uid                    :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester.#{n}@example.com" }
    sequence(:username) { |n| "username.#{n}" }
    first_name { 'MyString' }
    last_name { 'MyString' }
    password { 'MyString' }
    sequence(:reset_password_token) { |n| "MyString.#{n}" }
    reset_password_sent_at { '2019-03-08 15:33:28' }
    remember_created_at { '2019-03-08 15:33:28' }
    sign_in_count { 1 }
    current_sign_in_at { '2019-03-08 15:33:28' }
    last_sign_in_at { '2019-03-08 15:33:28' }
    current_sign_in_ip { '' }
    last_sign_in_ip { '' }
    sequence(:confirmation_token) { |n| "MyString.#{n}" }
    confirmed_at { '2019-03-08 15:33:28' }
    confirmation_sent_at { '2019-03-08 15:33:28' }
    unconfirmed_email { 'MyString' }
    created_at { '2019-03-08 15:33:28' }
    updated_at { '2019-03-08 15:33:28' }

    trait :invalid do
      email { nil }
    end

    trait :updated do
      first_name { 'test' }
    end
  end
end
