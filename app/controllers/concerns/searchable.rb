# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  def search
    @query = params[:query]

    @pagy, @items = pagy(
      index_relation.search_by(@query),
      page: params[:page],
      items: params[:items]
    )

    render :index
  end
end
