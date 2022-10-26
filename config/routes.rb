# frozen_string_literal: true

Rails.application.routes.draw do
  resources :commits
  root to: 'contributors#index'
  resources :contributors, only: 'index', param: :name do
    resources :commits, only: 'index'
    collection do
      get 'search'
    end
  end
  get 'contributors/:period', to: 'contributors#index', as: 'contributors_in_period'
end
