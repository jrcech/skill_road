# frozen_string_literal: true

module Utilities
  module ButtonsHelper
    def new_button(options = {})
      {
        title: t('actions.new',
                 item: t("models.#{model_plural_symbol}.one")),
        path: path_for_new,
        icon: action_icon(:new),
        classes: bootstrap_class('success', options[:type])
      }
    end

    def edit_button(item, options = {})
      {
        title: t('actions.edit'),
        path: path_for_edit(item),
        icon: action_icon(:edit),
        classes: bootstrap_class('primary', options[:type])
      }
    end

    def destroy_button(item, options = {})
      {
        title: t('actions.destroy'),
        path: path_for_destroy(item),
        icon: action_icon(:destroy),
        classes: bootstrap_class('danger', options[:type]),
        method: :delete,
        data: {
          title: t('confirmations.destroy.title',
                   model: t("models.#{model_plural_symbol(item)}.one")),
          confirm: t('confirmations.destroy.confirm',
                     item: item.title),
          commit: t('confirmations.destroy.commit',
                    model: t("models.#{model_plural_symbol(item)}.one")),
          cancel: t('confirmations.destroy.cancel')
        }
      }
    end

    def reset_money_button(item, options = {})
      {
        title: t('actions.reset_money'),
        path: path_for_reset_money(item),
        icon: action_icon(:reset_money),
        classes: bootstrap_class('danger', options[:type]),
        data: {
          title: t('confirmations.reset_money.title',
                   model: t("models.#{model_plural_symbol(item)}.one")),
          confirm: t('confirmations.reset_money.confirm',
                     item: item.title),
          commit: t('confirmations.reset_money.commit',
                    model: t("models.#{model_plural_symbol(item)}.one")),
          cancel: t('confirmations.reset_money.cancel')
        }
      }
    end

    def archive_buttons(item, options = {})
      event = if item.archived?
                :unarchive
              else
                :archive
              end
      {
        title: t("actions.#{event}.event"),
        path: send("path_for_#{event}", item),
        icon: action_icon(event),
        classes: bootstrap_class('default', options[:type])
      }
    end

    def dropdown_separator
      { separator: true }
    end

    def duplicate_button(item, options = {})
      {
        title: t('actions.duplicate'),
        path: path_for_duplicate(item),
        icon: action_icon(:duplicate),
        classes: bootstrap_class('default', options[:type])
      }
    end

    def template_button(item, options = {})
      {
        title: t('actions.template'),
        path: path_for_template(item),
        icon: action_icon(:template),
        classes: bootstrap_class('default', options[:type])
      }
    end

    def state_button(item, event, state, options = {})
      return unless item.send("may_#{event}?")
      path = send("state_#{model_singular_symbol(item)}_path", item, event)

      button_tooltip(icon: state_icon(state),
                     title: t("actions.#{event}.event"),
                     path: path,
                     class: options[:class])
    end

    def convert_button(item, model, options = {})
      return if item.converted?
      button_tooltip(icon: 'refresh',
                     title: t('actions.convert', model: t("models.#{model}.one")),
                     path: path_for_convert(item),
                     class: options[:class])
    end

    def details_button(options = {})
      {
        title: t('actions.details'),
        icon: action_icon(:details),
        classes: options[:class] ? options[:class] : 'btn btn-info',
        path: 'javascript:void(0)',
        data: {
          toggle: 'collapse',
          target: '.panel-details',
          turbolinks: false
        }
      }
    end

    def ellipsis_button(*items)
      {
        title: '',
        icon: 'ellipsis-v',
        classes: 'btn btn-default',
        caret: false,
        menu_position: :right,
        dropdown_items: items.compact
      }
    end

    def related_button(item, *related_models)
      button = {}
      button[:title] = t('actions.related')
      button[:icon] = action_icon(:related)
      button[:dropdown_items] = dropdown_items(item, :show, related_models)
      button
    end

    def options_button(item, *related_models)
      button = {}
      button[:title] = t('actions.options')
      button[:icon] = action_icon(:options)
      button[:dropdown_items] = dropdown_items(item, :index, related_models)
      button
    end

    def menu_items(item, *related_models)
      dropdown_items(item, :index, related_models)
    end

    def children_button(parent, children, options = {})
      {
        title: t("models.#{children}.more"),
        icon: icon_for(children),
        path: path_for_children(parent, children),
        classes: bootstrap_class('default', options[:type])
      }
    end

    def edit_nested_button(parent)
      return unless model.respond_to? :canonical_parent
      return if model_singular_symbol(parent) != model.canonical_parent
      {
        title: t('actions.edit_nested',
                 items: t("models.#{model_plural_symbol}.more")),
        path: path_for_edit_nested(parent),
        icon: action_icon(:edit),
        classes: 'btn btn-primary',
        data: {
          disable_with: t('actions.loading')
        }
      }
    end

    # region User buttons
    def role_buttons(item, options = {})
      return if current_user.user_self?(item)
      return if item.has_role?(:admin)
      return unless current_user.has_role?(:owner)
      role = item.to_role
      {
        title: t("actions.make_#{role}"),
        icon: action_icon("make_#{role}".to_sym),
        path: send("make_#{role}_user_path", item),
        classes: bootstrap_class(role == :owner ? 'warning' : 'default',
                                 options[:type]),
        data: {
          title: t("confirmations.make_#{role}.title",
                   item: t("models.#{model_plural_symbol(item)}.one")),
          confirm: t("confirmations.make_#{role}.confirm",
                     item: item.title),
          commit: t("confirmations.make_#{role}.commit"),
          cancel: t("confirmations.make_#{role}.cancel")
        }
      }
    end

    def impersonate_button(item, options = {})
      return if current_user.user_self?(item)
      return if item.has_role?(:admin)
      return unless current_user.has_role?(:owner)
      {
        title: t('actions.impersonate'),
        icon: action_icon(:impersonate),
        path: impersonate_user_path(item),
        method: :post,
        classes: bootstrap_class('success', options[:type])
      }
    end

    def edit_user_button(item, options = {})
      return unless current_user.has_role?(:owner)
      edit_button(item, options).merge(path: path_for_edit_user(item))
    end

    def destroy_user_button(item, options = {})
      return if current_user.user_self?(item)
      return unless current_user.has_role?(:owner)
      destroy_button(item, options)
    end
    # endregion

    private

    def dropdown_items(item, action, dropdown_items)
      dropdown_links = []
      dropdown_items.each do |dropdown_item|
        next unless item_exist?(item, dropdown_item, action)

        hash = {}
        hash[:title] = dropdown_title(item, dropdown_item, action)
        hash[:path] = dropdown_path(item, dropdown_item, action)
        hash[:icon] = icon_for(dropdown_item)
        hash[:count] = item.send(dropdown_item).size if action == :index && dropdown_item != :overview
        hash[:controller] = dropdown_item == :overview ? item.class.name.pluralize.underscore : dropdown_item.to_s

        dropdown_links << hash
      end

      dropdown_links
    end

    def item_exist?(item, dropdown_item, action)
      if action == :index
        return true if dropdown_item == :overview || item.send(dropdown_item)
      else
        return true if item.send(dropdown_item.to_s.singularize).present?
      end
      false
    end

    def dropdown_path(item, dropdown_item, action)
      case action
      when :index
        path = ''
        path += "#{item.class.to_s.underscore}_"
        path += "#{dropdown_item}_" unless dropdown_item == :overview
        path += 'path'
        send(path, item)
      when :show
        item.send(dropdown_item.to_s.singularize)
      end
    end

    def dropdown_title(item, dropdown_item, action)
      case action
      when :index
        if dropdown_item == :overview
          t('headers.overview')
        else
          t("models.#{dropdown_item}.more")
        end
      when :show
        item.send(dropdown_item.to_s.singularize).title
      end
    end

    def bootstrap_class(bootstrap_color = nil, type = nil)
      bootstrap_color ||= 'default'

      if type == :dropdown
        "dropdown-#{bootstrap_color}"
      else
        "btn btn-#{bootstrap_color}"
      end
    end
  end
end
