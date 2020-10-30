# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
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
end
