Rails.application.routes.draw do
  get 'orders/create'
  get 'orders/my_orders'
  get 'tickets/update'
  get 'tickets/destroy'
  get 'tickets/create'
  get 'listings/index'
  get 'listings/show'
  get 'listings/new'
  get 'listings/create'
  get 'listings/edit'
  get 'listings/update'
  get 'listings/destroy'
  get 'events/index'
  get 'events/show'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
