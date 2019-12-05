Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bils do
    collection do
      get '/show/:id', to: 'bill#index'
      post '/create_exp', to: 'bill#create'
      post '/get_month_data/:id', to: 'bill#get_month_data'
      post '/edit_expence', to: 'bill#update'
    end
  end

  resources :users do
    collection do
      post '/login', to: 'users#login'
      get '/reset_token/:id', to: 'users#generate_reset_token'
      post '/change_password/:id/:token', to: 'users#reset_password'
    end
  end


  get '/get_month_and_year_data/:id', to: 'analyze#get_month_and_year_data'
  get '/get_monthly_data/:id&:month&:year', to: 'analyze#get_monthly_data'
end
