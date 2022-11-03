# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'contributors#index'
  resources :contributors, only: %i(index), param: :name do
    resources :commits, only: %i(index)
    collection do
      resources :search, only: %i(index), controller: 'contributors/search'
    end
  end
  
  get 'contributors/:period', to: 'contributors#index', as: 'contributors_in_period'
  resources :ping_tasks, only: :none do
    collection do
      get :fetch_commit
    end
  end
end
