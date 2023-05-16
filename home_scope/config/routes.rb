Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "properties#index"

  namespace :admin do
    # Routes for admin properties under the index, new, and create actions
    resources :properties, only: [:index, :new, :create]

    # Route for deleting a property with a given ID
    delete 'admin/properties/:id', to: 'admin/properties#destroy', as: 'admin_property'

    resources :properties do
      # Route for editing a property on a member level (admin/properties/{id}/edit)
      get 'edit', on: :member
    end
  end

  # Routes for properties under the index action
  resources :properties, only: [:index]
end
