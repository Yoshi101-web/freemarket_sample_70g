Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'locations', to: 'users/registrations#new_location'
    post 'locations', to: 'users/registrations#create_location'
  end
  
  root "items#index"
  namespace :items do
    resources :searches, only: :index
  end
  resources :items do
    member do
      get :confirm
      post   '/like/:item_id' => 'likes#like',   as: 'like'
      delete '/like/:item_id' => 'likes#unlike', as: 'unlike'
    end
    collection do
      get :category_children
      get :category_grandchildren
    end
    resources :comments, only: :create
    resources :images, only: [:index,:create]
  end
  resources :users, only: [:show] do
    member do
      get :profile_edit
      post :profile_update
      get :location_edit
      post :location_update
      get :onsale
      get :done
      get :bought
      get :like
    end
    resources :profile, only: [:index]
    resources :creditcards, only: :index
    resources :location, only: :index
  end
  resources :creditcards, only: [:new, :show] do
    collection do
      post 'show', to: 'creditcards#show'
      post 'pay', to: 'creditcards#pay'
      post 'delete', to: 'creditcards#delete'
    end
  end
  resources :purchases, only: [:index] do
    member do
      get 'index', to: 'purchases#index'
      get 'pay', to: 'purchases#pay'
      get 'done', to: 'purchases#done'
    end
  end
  resources :categories, only: [:show]
end