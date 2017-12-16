Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'

  resources :users, only: %i(new create show) do
  	get :autocomplete_user_email, :on => :collection
  end
  resources :sessions, only: %i(create destroy)

end
