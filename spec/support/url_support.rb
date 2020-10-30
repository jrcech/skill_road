# frozen_string_literal: true

module UrlSupport
  attr_reader :resource, :action, :namespace

  def url_for(resource, options = {})
    @resource = resource
    @action = options[:action]
    @namespace = options[:namespace]

    construct_url
  end

  private

  url_actions = %i[
    index
    show
    new
    edit
    destroy
  ]

  url_actions.each do |url_action|
    define_method("#{url_action}?") do
      return true if action == url_action

      false
    end
  end

  def action_prefix?
    return true if new? || edit?

    false
  end

  def construct_url
    url = +''
    url << "#{action}_" if action_prefix?
    url << "#{namespace}_" if namespace.present?
    url << "#{resource}_url"

    url
  end
end

RSpec.configure do |config|
  config.include UrlSupport
end
