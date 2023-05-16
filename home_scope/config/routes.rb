Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "properties#index"

  namespace :admin do
    resources :properties, only: [:index, :new, :create, :destroy]
    delete 'admin/properties/:id', to: 'admin/properties#destroy', as: 'admin_property'

    resources :properties do
      get 'edit', on: :member
    end
  end

  resources :properties, only: [:index]
end
