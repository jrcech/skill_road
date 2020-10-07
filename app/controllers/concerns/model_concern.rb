# frozen_string_literal: true

module ModelConcern
  extend ActiveSupport::Concern

  def model_plural
    model.to_s.pluralize
  end

  def model_plural_symbol
    model_plural.underscore.to_sym
  end

  def path_for_new
    path = 'new_'
    path += namespace if namespaced?
    path += "#{controller_name.singularize}_path"

    send(path, model_parent ? { return_to: model_parent } : nil)
  end

  private

  def model
    case @resources
    when ApplicationRecord
      @resources.class
    when ActiveRecord::Relation
      @resources.name.safe_constantize
    else
      controller_name.classify.safe_constantize
    end
  end

  def namespace
    namespace = ''
    namespace += "#{controller_namespace}_" if controller_namespaced?
    namespace += "#{model_parent}_" if model_nested?

    namespace
  end

  def namespaced?
    return true if model_nested? || controller_namespaced?

    false
  end

  def model_parent
    request.path[%r{/([a-z_]+)/\d+}, 1].singularize if model_nested?
  end

  def model_nested?
    params.keys.any? { |key| key.to_s.match(/_id/) }
  end

  def controller_namespace
    return controller_path.split('/').first if controller_namespaced?

    nil
  end

  def controller_namespaced?
    return true if controller_name != controller_path

    false
  end
end
