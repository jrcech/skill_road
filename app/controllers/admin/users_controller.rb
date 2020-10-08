# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    def index
      @pagy, @items = pagy(
        User.order(updated_at: :desc),
        page: params[:page],
        items: params[:items],
        size: [1, 4, 4, 1],
        per_page: [5, 10, 20, 50, 100]
      )
    end
  end
end
