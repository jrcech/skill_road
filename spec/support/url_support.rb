# frozen_string_literal: true

module UrlSupport
  attr_reader :action

  def url_for(options = {})
    @action = options[:action]

    construct_url
  end

  private

  url_actions = %i[
    index
    show
    new
    edit
    create
    update
    destroy
  ]

  url_actions.each do |url_action|
    define_method("#{url_action}?") do
      return true if action == url_action

      false
    end
  end

  def construct_url
    url = +''
    url << "#{action}_" if action_prefix?
    url << "#{namespace}_" if namespace.present?
    url << "#{format_resource}_url"

    url
  end

  def action_prefix?
    return true if new? || edit?

    false
  end

  def format_resource
    return resource_plural_symbol if index? || create? || update?

    resource_singular_symbol
  end
end

RSpec.configure do |config|
  config.include UrlSupport
end
