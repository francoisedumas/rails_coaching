Rails.application.routes.draw do
  resources :quotes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "quotes#index"

  resource :api_viewer, controller: "api_viewer", only: [:show]
end
