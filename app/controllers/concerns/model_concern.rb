# frozen_string_literal: true

module ModelConcern
  extend ActiveSupport::Concern

  def model_string
    model.to_s
  end

  alias model_singular model_string

  def model_singular_symbol
    model_singular.underscore.to_sym
  end

  def model_singular_titleize
    model_singular.titleize
  end

  def model_plural
    model_string.pluralize
  end

  def model_plural_symbol
    model_plural.underscore.to_sym
  end

  def controller_singular
    controller_name.singularize
  end

  def controller_singular_symbol
    controller_singular.underscore.to_sym
  end

  def controller_plural
    controller_name
  end

  def controller_plural_symbol
    controller_plural.underscore.to_sym
  end

  def model_controller_plural_same?
    return true if model_plural_symbol == controller_plural_symbol

    false
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

  def model_nested?
    params.keys.any? { |key| key.to_s.match(/_id/) }
  end

  def controller_namespaced?
    return true if controller_name != controller_path

    false
  end

  def resource_namespaced?
    return true if model_nested? || controller_namespaced?

    false
  end

  def model_parent
    request.path[%r{/([a-z_]+)/\d+}, 1].singularize if model_nested?
  end

  def controller_namespace
    return controller_path.split('/').first if controller_namespaced?

    nil
  end

  def model_parent_id
    request.path[%r{/[a-z_]+/(\d+)}, 1]
  end

  def resource_namespace
    namespace = ''
    namespace += "#{controller_namespace}_" if controller_namespaced?
    namespace += "#{model_parent}_" if model_nested?

    namespace
  end
end
