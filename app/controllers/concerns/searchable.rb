# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  def search
    @query = params[:query]

    @pagy, @items = pagy(
      User.search_by(@query).order(updated_at: :desc),
      page: params[:page],
      items: params[:items],
      size: [1, 4, 4, 1],
      per_page: [5, 10, 20, 50, 100]
    )

    render :index
  end
end
