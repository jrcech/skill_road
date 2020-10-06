# frozen_string_literal: true

module ModelOwner
  extend ActiveSupport::Concern

  def model(resources = nil)
    case resources
    when ApplicationRecord
      resources.class
    when ActiveRecord::Relation
      resources.name.safe_constantize
    else
      controller_name.classify.safe_constantize
    end
  end

  def model?(resources = nil)
    model(resources).present?
  end

  def model_singular(resources = nil)
    model(resources).to_s
  end

  def model_plural(resources = nil)
    model(resources).to_s.pluralize
  end

  def model_singular_symbol(resources = nil)
    model_singular(resources).underscore.to_sym
  end

  def model_plural_symbol(resources = nil)
    model_plural(resources).underscore.to_sym
  end

  def model_singular_titleized(resources = nil)
    model_singular(resources).titleize
  end

  def model_nested?
    params.keys.any? { |key| key.to_s.match(/_id/) }
  end

  def model_parent
    request.path[/\/([a-z_]+)\/\d+/, 1].singularize if model_nested?
  end

  def model_parent_symbol
    model_parent.to_sym
  end

  def model_parent_id
    request.path[/\/[a-z_]+\/(\d+)/, 1]
  end

  def namespaces_array
    params[:controller].split('/') - [controller_name]
  end

  def namespaced_controller_symbol
    params[:controller].split('/').join('_')
  end

  def item_controller_name
    @item.class.name.pluralize.underscore
  end

  def item_controller_name_singular
    item_controller_name.singularize
  end

  def scope_method
    return "for_#{model_parent}".to_sym if model_nested?
    :for_team
  end

  def scope_resource
    return @parent if model_nested?
    @team
  end

  def path_for_index
    path = ''
    path += "#{model_parent_symbol}_" if model_nested?
    path += "#{model_plural_symbol}_path"

    send(path, model_nested? ? @parent : I18n.locale)
  end

  def format_namespace
    namespace = nil
    namespace ||= model.namespace if model.respond_to?(:namespace)

    return namespace.map(&:to_s).join('_') if namespace.is_a?(Array)
    return namespace.to_s if namespace
    nil
  end
end
