# frozen_string_literal: true

module Utilities
  module IconsHelper
    def icon_for(resource)
      case resource
      when :members, :teams
        'users'
      when :users
        'user-circle-o'
      when :clients
        'address-book-o'
      when :projects
        'briefcase'
      when :orders
        'credit-card'
      when :product_increments, :template_product_increments
        'cubes'
      when :budgets
        'dollar'
      when :features
        'lightbulb-o'
      when :requirements
        'check-square-o'
      when :billables, :template_billables
        'calculator'
      when :deliverables
        'cube'
      when :contact_people, :contacts
        'address-card-o'
      when :accountable_types
        'exchange'
      when :technologies
        'rocket'
      when :platforms
        'database'
      when :client_relations
        'handshake-o'
      when :activities
        'child'
      when :services
        'wrench'
      when :applications
        'th-large'
      when :team_fixed_expenses, :project_fixed_expenses
        'upload'
      when :team_fixed_incomes, :project_fixed_incomes
        'download'
      when :payments, :invoiceable_payments
        'money'
      when :settings
        'cogs'
      when :rewards
        'trophy'
      when :dashboard, :overview
        'dashboard'
      when :job_positions
        'id-card'
      when :departments
        'coffee'
      when :opportunities
        'truck'
      when :leads
        'leaf'
      when :invoiceables
        'file-text-o'
      when :templates
        'copy'
      when :milestones, :milestone_types
        'flag'
      when :phases
        'calendar'
      end
    end

    def action_icon(action)
      case action
      when :related
        'share'
      when :options
        'cogs'
      when :details
        'info'
      when :edit
        'pencil'
      when :new
        'plus'
      when :destroy
        'trash'
      when :archive, :unarchive
        'archive'
      when :reset_money
        'eraser'
      when :duplicate
        'files-o'
      when :template
        'file-text-o'
      when :make_member
        'angle-double-down'
      when :make_owner
        'angle-double-up'
      when :impersonate
        'user-o'
      when :preview
        'eye'
      when :export
        'download'
      when :import
        'upload'
      when :add
        'plus-square'
      when :search
        'search'
      end
    end

    def chart_icon(chart)
      case chart
      when :timeline
        'tasks'
      end
    end
    def state_icon(state)
      case state
      when :off
        'power-off'
      when :active, :created, :planned
        'inbox'
      when :pending, :postponed, :invoiceable
        'clock-o'
      when :upcoming, :invoiced
        'paper-plane'
      when :archived
        'archive'
      when :cancelled, :not_perspective
        'times'
      when :rejected
        controller_name == 'orders' ? 'user-times' : 'times'
      when :delivered
        'truck'
      when :prospecting
        'wpexplorer'
      when :converted
        'refresh'
      when :negotiation, :proposed
        'comments'
      when :development
        'code'
      when :satisfied, :finished, :accepted
        'check'
      when :approved
        controller_name == 'orders' ? 'handshake-o' : 'check'
      when :paid
        'money'
      when :in_development, :ongoing
        'keyboard-o'
      when :all
        'th-list'
      else
        'question'
      end
    end

    def tooltip(title, icon = 'question-circle-o', classes = nil, placement = :top)
      fa_icon(icon,
              title: title,
              class: classes,
              data: {
                toggle: :tooltip,
                placement: placement
              })
    end

    def iconize_breadcrumbs(breadcrumbs)
      breadcrumbs_array = strip_tags(breadcrumbs).split('/')

      breadcrumbs_array.each do |breadcrumb|
        breadcrumb_symbol = breadcrumb.downcase.tr(' ', '_').to_sym
        label = t("breadcrumbs.#{breadcrumb_symbol}")

        icon = icon_for(breadcrumb_symbol)
        tooltip = tooltip(label, icon)

        breadcrumbs.gsub!('>/<', '><')
        breadcrumbs.gsub!(/>#{label}</, ">#{tooltip}<") if icon
      end

      breadcrumbs.html_safe
    end

    def boolean_icon(state, date = nil)
      if state
        icon = fa_icon('check')
        icon = icon + ' at ' + l(date, format: :short_date) if date

        icon
      else
        fa_icon('times')
      end
    end

    def search_icon_for(title)
      tooltip = tooltip(t('tooltips.search'), 'search', 'minor')
      "#{title} #{tooltip}".html_safe
    end

    def sort_icon_for(title)
      "#{title} #{fa_icon('sort-amount-asc', class: 'minor')}".html_safe
    end

    def icon_with_tooltip(resource)
      tooltip(t("tooltips.#{resource}"), icon_for(resource))
    end

    def resource_icon(resource)
      resource.icon_fa.gsub('fa-', '')
    end

    def milestone_icon(resource)
      resource.icon.gsub('fa-', '')
    end

    def deliverable_tooltip(resource)
      title = ''
      title += resource.deliverable.title if resource.deliverable?
      title += " (#{resource.platform.title})" if resource.platform?
      title += " [#{resource.technology.title}]" if resource.technology?

      if resource.platform?
        return tooltip(title, resource_icon(resource.platform), 'minor')
      end

      title
    end

    def platform_tooltip(resource)
      title = ''
      title += "#{resource.platform.title} " if resource.platform?
      title += "[#{resource.technology.title}]" if resource.technology?

      if resource.platform?
        return tooltip(title, resource_icon(resource.platform), 'fa-2x')
      end

      title
    end

    def milestone_tooltip(resource)
      title = ''
      title += "#{resource.milestone_type.title} " if resource.milestone_type?
      tooltip(title, milestone_icon(resource.milestone_type), 'fa-2x')
    end

    def button_tooltip(options = {})
      btn_class = options[:class] || :primary

      link_to(fa_icon(options[:icon]),
              options[:path],
              title: options[:title],
              class: "btn btn-#{btn_class}",
              data: {
                toggle: :tooltip
              })
    end

    def explained_text(text, tooltip)
      "#{text} #{tooltip(tooltip)}".html_safe
    end
  end
end
