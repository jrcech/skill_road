# frozen_string_literal: true

module ModelOwner
  extend ActiveSupport::Concern

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

  def model_plural
    model.to_s.pluralize
  end

  def model_plural_symbol
    model_plural.underscore.to_sym
  end
end
