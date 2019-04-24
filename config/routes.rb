Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: "home#index"

  get '/profiles', to: 'home#profiles'
  get '/shop', to: 'shops#index'

  resources :products, only: [:index, :new, :create]
  resources :orders, only: [:index]
  resources :subscriptions, only: [:create]

  mount Facebook::Messenger::Server, at: 'bot'
end
