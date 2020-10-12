# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Searchable

    attr_reader :relation

    def index
      index_relation

      @pagy, @items = pagy(
        @index_relation,
        page: params[:page],
        items: params[:items]
      )
    end

    private

    def index_relation
      @index_relation = User.order(updated_at: :desc)
    end
  end
end
