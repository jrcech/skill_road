# frozen_string_literal: true

class LayoutGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  class_option :root_name, type: :string, default: 'homepage'
  class_option :authenticated, type: :boolean, default: true

  attr_reader :root_name, :authenticated

  def initialize_options
    @root_name = options['root_name']
    @authenticated = options['authenticated']
  end

  def template_controllers
    template(
      'app/controllers/layout_controller.rb.tt',
      "app/controllers/#{file_name}/#{file_name}_controller.rb"
    )

    template(
      'app/controllers/root_controller.rb.tt',
      "app/controllers/#{file_name}/#{root_name}_controller.rb"
    )
  end

  def template_slim
    template(
      'app/views/layouts/layout.html.slim.tt',
      "app/views/layouts/#{file_name}.html.slim"
    )

    template(
      'app/views/admin/root/index.html.slim.tt',
      "app/views/#{file_name}/#{root_name}/index.html.slim"
    )
  end

  def template_spec
    directory 'spec/support/shared_examples'

    template(
      'spec/requests/root_request_spec.rb.tt',
      "spec/requests/#{file_name}/#{root_name}_request_spec.rb"
    )
  end

  def inject_routes
    template 'config/routes.rb.tt', 'tmp/templates/config/routes.rb'

    routes = File.read('tmp/templates/config/routes.rb') << "\n"

    inject_into_file(
      'config/routes.rb',
      routes,
      before: "get '/:locale'"
    )

    remove_file 'tmp/templates/config/routes.rb'
    run 'rubocop --auto_correct_all config/routes.rb'
  end
end
