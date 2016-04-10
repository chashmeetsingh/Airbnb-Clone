Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :bookings
    resources :conversations
    resources :dogs
    resources :messages
    resources :stripe_customers

    root to: "users#index"
  end

  get 'home/index'

  get 'dog/index'

  post 'dog/add'

  post 'dog/remove'

  resources :conversations do
    resources :messages
  end

  get 'home/sitter'

  get '/profile' => 'home#profile'

  post '/search' => 'home#search'

  post 'home/update_profile'

  get '/user/:username' => 'home#public_profile', :constraints => { :username => /[^\/]+/ }

  post '/book' => 'booking#new'

  post 'booking/create'

  get 'booking/index'

  get 'dog/sample'

  root to: 'home#index'

  post 'dog/api'

  post 'booking/accept'

  get 'booking/sitter'

  devise_for :users
end
