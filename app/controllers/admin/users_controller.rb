# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Searchable

    attr_reader :relation

    before_action :index_relation, only: %i[index search]

    def index
      @pagy, @items = pagy(
        @index_relation,
        page: params[:page],
        items: params[:items]
      )
    end

    private

    def index_relation
      @index_relation = User.preload(:roles).order(updated_at: :desc)
    end
  end
end
