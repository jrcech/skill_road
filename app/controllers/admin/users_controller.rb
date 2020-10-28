# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Searchable

    before_action(
      :set_item,
      only: %i[
        show
        edit
        update
        destroy
        make_member
        make_admin
      ]
    )

    before_action :set_items, only: %i[index search]

    def index
      @pagy, @items = pagy(
        @items,
        page: params[:page],
        items: params[:items]
      )
    end

    def show; end

    def new
      @item = User.new
    end

    def edit; end

    def create
      @item = User.new(user_params)

      if @item.skip_confirmation_notification! && @item.save
        flash[:success] = t('success.create', model: helpers.model_singular)

        redirect_to admin_users_path
      else
        render :new
      end
    end

    def update
      if @item.update user_params
        flash[:success] = t('success.update', model: helpers.model_singular)

        redirect_to admin_users_path
      else
        @return_to = params[:return_to]

        render :edit
      end
    end

    def destroy
      if @item == current_user
        flash[:error] = t('errors.destroy_yourself')
      elsif @item.destroy
        flash[:success] = t('success.destroy', model: helpers.model_singular)
      else
        flash[:error] = t('errors.destroy')
      end

      redirect_back fallback_location: admin_users_path
    end

    %w[member admin].each do |role|
      define_method("make_#{role}") do
        if @item.send("make_#{role}")
          flash[:success] = t('success.change_role', role: role)
        else
          flash[:error] = t('errors.change_role')
        end

        redirect_back fallback_location: admin_users_path
      end
    end

    private

    def set_items
      @items = User.preload(:roles).order(updated_at: :desc)
    end

    def set_item
      @item = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        :first_name,
        :last_name,
        :username,
        :password,
        :password_confirmation
      )
    end
  end
end
