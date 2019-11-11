Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bils do
    collection do
      get '/show', to: 'bill#index'
    end
  end
end
