# frozen_string_literal: true

module Utilities
  module ButtonsHelper
    def new_button
      {
        title: t(
          'actions.new',
          item: t("models.#{model_plural_symbol}.one")
        ),
        path: path_for_new,
        icon: action_icon(:new),
        classes: bootstrap_class('success')
      }
    end

    private

    def bootstrap_class(bootstrap_color = 'primary')
      "btn btn-#{bootstrap_color}"
    end
  end
end
