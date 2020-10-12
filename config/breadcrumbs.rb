# frozen_string_literal: true

crumb :root do
  link 'Home', admin_root_path
end

crumb :users do
  link 'Users', admin_users_path
end
