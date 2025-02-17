# config/routes.rb

Rails.application.routes.draw do
  devise_for :users  # Keep Devise at the top for authentication

  resources :users do
    member do
      get :assign_admin  # Changed from PUT to GET
      get :remove_admin  # Changed from PUT to GET
    end
  end

  resources :projects do
    # Add the route for destroying an attachment
    member do
      delete 'destroy_attachment/:attachment_id', to: 'projects#destroy_attachment', as: 'destroy_attachment'
      # Route for showing the attachment
      get 'show_attachment/:attachment_id', to: 'projects#show_attachment', as: 'show_attachment'
    end
  end

  # Other routes
  get "home/about"
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
