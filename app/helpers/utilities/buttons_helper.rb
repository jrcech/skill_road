# frozen_string_literal: true

module Utilities
  module ButtonsHelper
    attr_reader :button

    def new_button
      {
        title: t(
          'actions.new',
          item: t("models.#{model_plural_symbol}.one")
        ),
        path: path_for(:new),
        icon: action_icon(:new),
        action: :new
      }
    end

    def edit_button
      {
        title: t('actions.edit'),
        path: path_for(:edit),
        icon: action_icon(:edit),
        action: :edit
      }
    end

    def destroy_button
      {
        title: t('actions.destroy'),
        path: path_for(:destroy),
        icon: action_icon(:destroy),
        method: :delete,
        data: destroy_button_confirmation,
        action: :destroy
      }
    end

    def ellipsis_button(*items)
      {
        title: '',
        icon: 'ellipsis-v',
        class: 'btn btn-light',
        caret: false,
        menu_position: :right,
        dropdown_items: dropdown_items(items)
      }
    end

    def button_class
      "#{construct_button_class}#{construct_dropdown_class}"
    end

    private

    def construct_button_class
      return nil if button.key?(:dropdown)
      return button[:class] if button.key?(:class)
      return "btn btn-#{bootstrap_class}" if bootstrap_class.present?

      'btn btn-primary'
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
  end
end
