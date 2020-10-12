# frozen_string_literal: true

crumb :root do
  link t('controller.dashboard'), admin_root_path
end

crumb :users do
  link(
    tooltip(t('models.users.more'), model_icon(:users)),
    admin_users_path
  )
end
