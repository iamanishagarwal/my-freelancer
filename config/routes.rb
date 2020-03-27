# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  resources :freelancers
  resources :clients

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
