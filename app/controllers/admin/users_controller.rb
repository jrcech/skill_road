# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    def index
      @items = User.order(updated_at: :desc)
    end
  end
end
