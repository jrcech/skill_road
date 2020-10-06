# frozen_string_literal: true

module Utilities
  module PathsHelper
    def format_controller_name
      if controller_name == controller_path
        puts 1
        return "#{model_parent}_#{controller_name}" if model_nested?

        controller_name
      else
        full_controller = controller_path.tr('/', '_')
        return "#{model_parent}_#{full_controller}" if model_nested?

        puts full_controller
        full_controller
      end
    end

    def return_to_for_edit
      return "#{model_parent}_#{model_parent_id}" if model_nested?
      return nil if action_name == 'show'
      controller_name
    end

    def return_to_for_destroy(item)
      return 'parent' if !model_nested? && @items.blank? && action_name == 'index' && model_plural_symbol(item) == controller_name.to_sym
      return 'parent' if model_nested? && action_name == 'index' && model_plural_symbol(item) != controller_name.to_sym && item.respond_to?(:canonical_parent)
      return 'parent' if action_name == 'show' && item.respond_to?(:canonical_parent)
      return "#{model_parent}_#{model_parent_id}" if model_nested? && model_plural_symbol(item) == controller_name.to_sym
      nil
    end

    def path_for_show(item)
      path = ''
      if controller_name != controller_path
        path += "#{format_controller_name.split.first}_"
        path += "#{format_namespace}_" if format_namespace
        path += 'path'
      else
        path += "#{format_namespace}_" if format_namespace
        path += "#{model_singular_symbol}_path"
      end
      puts path
      send(path, item)
    end

    def path_for_new
      path = 'new_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{format_controller_name.singularize}_path"
      send(path, model_parent ? { return_to: model_parent } : nil)
    end

    def path_for_edit(item)
      path = 'edit_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_path"
      send(path, item, return_to: return_to_for_edit)
    end

    def path_for_destroy(item)
      path = ''
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_path"
      send(path, item, return_to: return_to_for_destroy(item))
    end

    def path_for_reset_money(item)
      path = 'reset_money_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_path"
      send(path, item)
    end

    def path_for_reorder
      path = 'reorder_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{format_controller_name}_path"
      send(path)
    end

    def path_for_duplicate(item = nil)
      path = 'duplicate_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_path"
      send(path, item)
    end

    def path_for_template(item = nil)
      path = 'template_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_path"
      send(path, item.present? ? item : @item)
    end

    def path_for_search
      path = 'search_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{format_controller_name}_path"
      send(path)
    end

    def path_for_archive(item)
      path = 'archive_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_path"
      send(path, item)
    end

    def path_for_unarchive(item)
      path = 'unarchive_'
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_path"
      send(path, item)
    end

    def path_for_pagination
      path = ''
      path += 'search_' if action_name == 'search'
      path += 'reorder_' if action_name == 'reorder'
      path += "#{format_namespace}_" if format_namespace
      path += "#{format_controller_name}_path"
      path.to_sym
    end

    def path_for_issue
      path = 'issue_'
      path += 'services_' if current_user.more_services?
      path += "#{format_controller_name.singularize}_path"

      params = { service: current_user.service }
      send(path, current_user.more_services? ? @item.id : params)
    end

    def path_for_convert(items)
      path = "#{model_singular_symbol}_"
      path += 'convert_path'
      send(path, items)
    end

    def path_for_children(parent, children)
      path = "#{model_singular_symbol(parent)}_"
      path += "#{children}_path"
      send(path, parent)
    end

    def path_for_edit_user(item)
      path = 'edit_'
      path += "#{format_namespace}_" if format_namespace
      path += 'member_' unless current_user.user_self?(item)
      path += 'user_path'
      send(path, item, return_to: return_to_for_edit)
    end

    def path_for_edit_nested(item)
      path = ''
      path += "#{format_namespace}_" if format_namespace
      path += "#{model_singular_symbol(item)}_"
      path += 'edit_nested_path'
      send(path, item, return_to: return_to_for_edit)
    end
  end
end
