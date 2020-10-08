# frozen_string_literal: true

module PathConcern
  extend ActiveSupport::Concern

  attr_reader :item, :action

  def path_for(action)
    @action = action

    send_path
  end

  private

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

  def action_prefix?
    return true if new? || edit?

    false
  end

  def resource_for_action
    return controller_singular_symbol if new?

    model_singular_symbol
  end

  def construct_path
    path = +''
    path << "#{action}_" if action_prefix?
    path << resource_namespace if resource_namespaced?
    path << "#{resource_for_action}_path"
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

  def send_path
    return send construct_path, item if show?

    send construct_path, item, { return_to: return_to }
  end
end
