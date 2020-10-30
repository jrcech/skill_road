# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FrontendTest', type: :request do
  before do
    resource_for :frontend_test, :admin
  end

  include_examples 'GET /index authenticated'
end
