# frozen_string_literal: true

class LayoutGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  class_option :root_name, type: :string, default: 'homepage'

  attr_reader :root_name

  def initialize_options
    @root_name = options['root_name']
  end

  def template_files
    template 'app/controllers/layout_controller.rb.tt',
             "app/controllers/#{file_name}/#{file_name}_controller.rb"

    template 'app/controllers/root_controller.rb.tt',
             "app/controllers/#{file_name}/#{root_name}_controller.rb"

    template 'app/views/layouts/layout.html.slim.tt',
             "app/views/layouts/#{file_name}.html.slim"

    template 'app/views/admin/root/index.html.slim.tt',
             "app/views/#{file_name}/#{root_name}/index.html.slim"
  end

  def inject_routes
    template 'config/routes.rb.tt', 'tmp/templates/config/routes.rb'

    inject_into_file(
      'config/routes.rb',
      File.read('tmp/templates/config/routes.rb'),
      after: "devise_for :users, skip: :omniauth_callbacks\n\n"
    )

    remove_file 'tmp/templates/config/routes.rb'
    run 'rubocop --auto_correct_all config/routes.rb'
  end
end
