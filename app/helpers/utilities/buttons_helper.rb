# frozen_string_literal: true

module Utilities
  module ButtonsHelper
    def new_button
      {
        title: t(
          'actions.new',
          item: t("models.#{model_plural_symbol}.one")
        ),
        path: path_for(:new),
        icon: action_icon(:new),
        class: bootstrap_class('success')
      }
    end

    def edit_button
      {
        title: t('actions.edit'),
        path: path_for(:edit),
        icon: action_icon(:edit)
      }
    end

    def destroy_button
      {
        title: t('actions.destroy'),
        path: path_for(:destroy),
        icon: action_icon(:destroy),
        classes: bootstrap_class('danger'),
        method: :delete,
        data: destroy_button_confirmation
      }
    end

    def destroy_button_confirmation
      model_translation = t("models.#{model_plural_symbol}.one")
      {
        title: t('confirmations.destroy.title', model: model_translation),
        confirm: t('confirmations.destroy.confirm', item: item.title),
        commit: t('confirmations.destroy.commit', model: model_translation),
        cancel: t('confirmations.destroy.cancel')
      }
    end

    def ellipsis_button(*items)
      {
        title: '',
        icon: 'ellipsis-v',
        classes: 'btn btn-light',
        caret: false,
        menu_position: :right,
        dropdown_items: items.compact
      }
    end

    def dropdown_separator
      { separator: true }
    end

    private

    def bootstrap_class(bootstrap_color = 'primary')
      "btn btn-#{bootstrap_color}"
    end
  end
end
