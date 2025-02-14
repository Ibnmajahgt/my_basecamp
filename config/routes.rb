Rails.application.routes.draw do
  devise_for :users  # Move this to the top!

  resources :users do
    member do
      get :assign_admin  # Changed from PUT to GET
      get :remove_admin  # Changed from PUT to GET
    end
  end

  resources :projects

  # get "home/index"
  get "home/about"
  root "home#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
