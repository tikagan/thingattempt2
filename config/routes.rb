Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'

  resources :users, only: %i(new create ) do
    get :autocomplete_user_email, :on => :collection
  end

  get '/cbit/:email', to: 'users#get_user_info', as: 'get_user_info'
  get '/scrape', to: 'application#scrape_users', as: 'scrape_info'
  resources :sessions, only: %i(create destroy)
end