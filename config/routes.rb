Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :animal_types, only: [:index, :show]
    end
  end


end
