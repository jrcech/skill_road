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
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, uniqueness: true

  after_create :assign_default_role

  rolify
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :trackable,
    :confirmable,
    :lockable,
    :omniauthable,
    omniauth_providers: %i[facebook google]
  )

  scope :search_by, (lambda { |query|
    where('users.email ILIKE ? OR users.first_name ILIKE ? OR users.last_name ILIKE ?',
          "%#{query.to_s.downcase}%",
          "%#{query.to_s.downcase}%",
          "%#{query.to_s.downcase}%")
  })

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      process_user(user, auth)
      user.skip_confirmation!
    end
  end

  def self.process_user(user, auth)
    info = auth.info

    user.email = info.email
    user.password = Devise.friendly_token[0, 20]
    user.first_name = info.first_name
    user.last_name = info.last_name
  end

  def assign_default_role
    add_role :user if roles.blank?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  alias title full_name

  def role
    return :owner if has_cached_role? :owner
    return :admin if has_cached_role? :admin

    :member
  end

  def to_role
    return :member if role == :admin

    :admin
  end

  def make_member
    remove_role :admin
    remove_role :owner
  end

  def make_admin
    add_role :admin
  end
end
