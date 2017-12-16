Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'

  resources :users, only: %i(new create show)
  resources :sessions, only: %i(create destroy)

end
