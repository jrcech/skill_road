# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  include_examples(
    'GET authenticated examples',
    '/admin'
  )
end
