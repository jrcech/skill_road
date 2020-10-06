# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    def index
      relation = User.order(updated_at: :desc)
      @pagy, @items = pagy(relation, page: params[:page], items: 20)
    end
  end
end
