# frozen_string_literal: true

module Utilities
  module ColorHelper
    def bootstrap_class
      {
        new: 'success',
        edit: 'primary',
        destroy: 'danger'
      }[button[:action]]
    end
  end
end
