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
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create :user }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_uniqueness_of(:username).allow_nil }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe '#full_name' do
    it 'returns full name as a string' do
      user = build :user, first_name: 'John', last_name: 'Doe'

      expect(user.full_name).to eq 'John Doe'
    end
  end

  describe '#assign_default_role' do
    it 'assigns default member role' do
      expect(user.has_role?(:member)).to eq true
    end
  end

  describe '#role' do
    it 'returns owner role' do
      user.add_role :owner

      expect(user.role).to eq :owner
    end

    it 'returns admin role' do
      user.add_role :admin

      expect(user.role).to eq :admin
    end

    it 'returns member role' do
      expect(user.role).to eq :member
    end
  end

  describe '#to_role' do
    it 'returns member role for admin' do
      user.add_role :admin

      expect(user.to_role).to eq :member
    end

    it 'returns admin role for member' do
      expect(user.to_role).to eq :admin
    end
  end

  describe '#make_member' do
    it 'makes member from admin' do
      user.add_role :admin
      user.make_member

      expect(user.role).to eq :member
    end
  end

  describe '#make_admin' do
    it 'makes admin from member' do
      user.make_admin

      expect(user.role).to eq :admin
    end
  end
end
