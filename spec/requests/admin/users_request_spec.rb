# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # let!(:valid_attributes) { attributes_for :user }
  # let!(:invalid_attributes) { attributes_for :user, :invalid }

  actions = %i[
    index
    show
    new
    edit
  ]

  actions.each do |action|
    include_examples(
      "GET #{action} authenticated examples",
      action == :index ? :users : :user,
      :admin
    )
  end

  include_examples(
    'POST authenticated examples',
    :users,
    :admin
  )

  # context 'with an authenticated user' do
  #   before do
  #     sign_in_user
  #   end
  #
  #   context 'with valid attributes' do
  #     it 'adds a user' do
  #       expect do
  #         post admin_users_path, params: { user: valid_attributes }
  #       end.to change(User.all, :count).by(1)
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     it 'does not add a user' do
  #       expect do
  #         post admin_users_path, params: { user: invalid_attributes }
  #       end.not_to change(User.all, :count)
  #     end
  #   end
  # end
  #
  # context 'with a guest' do
  #   context 'with valid attributes' do
  #     it 'adds a user' do
  #       expect do
  #         post admin_users_path, params: { user: valid_attributes }
  #       end.not_to change(User.all, :count)
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     it 'does not add a user' do
  #       expect do
  #         post admin_users_path, params: { user: invalid_attributes }
  #       end.not_to change(User.all, :count)
  #     end
  #   end
  # end
end
