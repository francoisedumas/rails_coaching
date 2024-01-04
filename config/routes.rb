Rails.application.routes.draw do
  resources :quotes
  namespace :api do
    namespace :v1 do
      resources :quotes, only: [:index]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "quotes#index"

  resources :api_viewer, controller: "api_viewer", only: [:index]
  resources :addresses, only: [:new, :create, :show] do
    member do
      get :download
    end
  end
  resource :pdf, only: [:show] do
    member do
      get :download
    end
  end
end
