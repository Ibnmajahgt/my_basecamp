Rails.application.routes.draw do
  devise_for :users  # Keep Devise at the top for authentication

  resources :users do
    member do
      get :assign_admin
      get :remove_admin
    end
  end

  resources :projects do
    # Add discussions as a nested resource
    resources :discussions, only: [:new, :create, :index, :show, :edit, :update, :destroy] do  # ✅ Added :edit and :update
      resources :messages, only: [:new, :create, :show, :edit, :update, :destroy]
    end

    member do
      delete 'destroy_attachment/:attachment_id', to: 'projects#destroy_attachment', as: 'destroy_attachment'
      get 'show_attachment/:attachment_id', to: 'projects#show_attachment', as: 'show_attachment'
    end
  end

  # ✅ Updated "About" page route to be clean and standard
  get "about", to: "pages#about"  # Make sure you have a PagesController with an `about` action
  

  # Other routes
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
