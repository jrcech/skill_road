# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def request_params
    params = request.parameters
    except = %i[controller action]
    params = params.except(:except)

    params.except(*except)
  end
  # endregion

  def scope_params
    request_params.except(:page, :per, :query, :utf8, :scopable)
  end
end
