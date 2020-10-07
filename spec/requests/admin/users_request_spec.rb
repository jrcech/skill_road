# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include_examples(
    'GET authenticated examples',
    '/admin/users'
  )
end
