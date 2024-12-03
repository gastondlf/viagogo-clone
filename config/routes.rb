Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/events", to: "events#index"
  get "/events/:id/listings", to: "listings#index", as: "event_listings"
  get "/listings/new", to: "listings#new", as: "new_listing"
  get "/events/:id/listings/:id", to: "listings#show", as: "listing"
  patch "/events/:id/listings/:id", to: "listings#update"
  post "/listings", to: "listings#create"
  get "/my_listings", to: "listings#my_listings", as: "my_listings"
  delete "/listings/:id", to: "listings#destroy"
  get "listings/:id/orders/new", to: "orders#new", as: "new_order"
  post "/orders", to: "orders#create"
  get "/my_orders", to: "orders#my_orders", as: "my_orders"
  post "/tickets", to: "tickets#create"
  patch "/tickets/:id", to: "tickets#update"
  delete "/tickets/:id", to: "tickets#destroy"

end
