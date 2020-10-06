# frozen_string_literal: true

Rails.application.routes.draw do
  # region Concerns
  concern :paginatable do
    get '(page/:page(/per/:per))', action: :index, on: :collection, as: :paginated
  end

  concern :searchable do
    get 'search(/page/:page(/per/:per))', action: :search, on: :collection, as: :search
  end

  concern :orderable do
    get 'reorder', action: :reorder, on: :collection, as: :reorder
  end

  concern :archiveable do
    get 'archive', action: :archive, on: :member, as: :archive
    get 'unarchive', action: :unarchive, on: :member, as: :unarchive
  end

  concern :issuable do
    get 'issue', action: :new_issue, on: :member
    post 'issue', action: :issue, on: :member
    get 'issue/services', action: :services, on: :member
  end

  concern :stateable do
    get 'state/:event', action: :transition, on: :member, as: :state
  end

  concern :duplicable do
    get 'duplicate', action: :duplicate, on: :member, as: :duplicate
    get 'template', action: :template, on: :member, as: :template
  end

  concern :resetable do
    get 'reset_money', action: :reset_money, on: :member, as: :reset_money
  end

  concern :nested_forms do
    get 'edit_nested', action: :edit_nested, as: :edit_nested
    put 'edit_nested', action: :update_nested, as: :update_nested
  end
  # endregion

  devise_for :users,
             only: :omniauth_callbacks,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  scope '(:locale)', locale: /en|cs/ do
    devise_for :users, skip: :omniauth_callbacks

    namespace :admin do
      get :frontend_test, to: 'frontend_test#index'

      resources :users, concerns: %i[searchable paginatable archiveable]

      root to: 'dashboard#index'
    end

    get '/:locale', to: 'homepage#index'

    root to: 'homepage#index'
  end
end
