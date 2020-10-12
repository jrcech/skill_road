# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Searchable

    attr_reader :relation

    def index
      index_relation

      @pagy, @items = pagy(
        @relation,
        page: params[:page],
        items: params[:items]
      )
    end

    private

    def index_relation
      @relation = User.order(updated_at: :desc)
    end
  end
end
