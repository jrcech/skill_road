# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FrontendTest', type: :request do
  include_examples 'GET authenticated examples', '/admin/frontend_test'
end
