# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Searchable

    before_action :index_relation, only: %i[index search]
    before_action :load_item, only: %i[destroy make_member make_admin]

    permits(
      :email,
      :first_name,
      :last_name,
      :username,
      :password,
      :password_confirmation
    )

    def index
      @pagy, @items = pagy(
        index_relation,
        page: params[:page],
        items: params[:items]
      )
    end

    def new
      @item = User.new
    end

    def create(user)
      @item = User.new(user)

      if @item.skip_confirmation_notification! && @item.save
        redirect_to admin_users_path, notice: 'Application was successfully created.'
      else
        render :new
      end
    end

    def destroy
      @item.destroy

      redirect_back(
        fallback_location: admin_users_path,
        notice: 'User was successfully destroyed.'
      )
    end

    def make_member
      notice = if @item.make_member
                 'User role was successfully changed to member'
               else
                 'User role cannot be changed'
               end

      redirect_back fallback_location: admin_users_path, notice: notice
    end

    def make_admin
      notice = if @item.make_admin
                 'User role was successfully changed to admin'
               else
                 'User role cannot be changed'
               end

      redirect_back fallback_location: admin_users_path, notice: notice
    end

    private

    def index_relation
      @index_relation = User.preload(:roles).order(updated_at: :desc)
    end

    def load_item(id)
      @item = User.find(id)
    end
  end
end
