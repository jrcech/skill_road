# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  def search
    index_relation

    @query = params[:query]

    @pagy, @items = pagy(
      @relation.search_by(@query),
      page: params[:page],
      items: params[:items]
    )

    render :index
  end
end
