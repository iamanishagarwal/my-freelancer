# frozen_string_literal: true

Rails.application.routes.draw do
  get 'proposals/create'
  Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'

  root 'home#index'

  get 'signup', to: 'users#new'
  resources :users, except: [:new] do
    member do
      get :confirm_email
    end
  end
  resources :freelancers
  resources :clients
  resources :jobs
  resources :proposals, only: %i[create destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
