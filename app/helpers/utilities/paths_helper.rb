# frozen_string_literal: true

module Utilities
  module PathsHelper
    attr_reader :item, :action, :per_page

    def path_for(action)
      @action = action

      send_path
    end

    def show?
      action == :show
    end

    def new?
      action == :new
    end

    def edit?
      action == :edit
    end

    def destroy?
      action == :destroy
    end

    def search?
      action == :search
    end

    def per_page_path
      return path_for(:search) if action_name == 'search'

      current_path
    end

    def current_path
      send "#{controller_namespace}_#{controller_plural_symbol}_path", merge_per_page_parameters
    end

    private

    def send_path
      return send construct_path, merge_per_page_parameters if search?
      return send construct_path, item if show?

      send construct_path, item, { return_to: return_to }
    end

    def construct_path
      path = +''
      path << "#{action}_" if action_prefix?
      path << resource_namespace if resource_namespaced?
      path << "#{resource_for_action}_path"
    end

    def action_prefix?
      return false if show? || destroy?

      true
    end

    def resource_for_action
      return model_singular_symbol if show? || edit? || destroy?
      return controller_singular_symbol if new?

      controller_plural_symbol
    end

    def canonical_parent?
      item&.canonical_parent
    end

    def return_to_for_edit
      return "#{model_parent}_#{model_parent_id}" if model_nested?
      return nil if action_name == 'show'

      controller_plural
    end

    def return_to_for_destroy_index
      return 'parent' if !model_nested? && @items.blank? && model_controller_same?
      return 'parent' if model_nested? && !model_controller_same? && canonical_parent?

      nil
    end

    def return_to_for_destroy
      return return_to_for_destroy_index if action_name == 'index'
      return 'parent' if action_name == 'show' && canonical_parent?
      return "#{model_parent}_#{model_parent_id}" if model_nested? && model_controller_same?

      nil
    end

    def return_to
      send "return_to_for_#{action}" if edit? && destroy?
      model_parent if new? && model_nested?

      nil
    end

    def merge_per_page_parameters
      query_parameters = request.query_parameters
      query_parameters.merge(
        {
          items: per_page,
          page: 1
        }
      )
    end
  end
end
