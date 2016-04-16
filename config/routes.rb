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

  root to: 'home#index'

  get 'home/index'
  get 'home/sitter'
  post '/api/search' => 'home#search_api'

  resources :conversations do
    resources :messages
  end

  # Profile
  get '/profile' => 'profile#profile'
  post 'profile/update_profile'
  get '/user/:username' => 'profile#public_profile', :constraints => { :username => /[^\/]+/ }

  post '/search' => 'home#search'

  # Booking
  get 'booking/index'
  post '/book' => 'booking#new'
  post 'booking/create'
  post 'booking/accept'
  get 'booking/sitter'
  get '/booking/:booking_id' => 'booking#show'
  get '/complete/:booking_id' => 'booking#complete'

  # Pets
  get 'pets/sample'
  get 'pets/index'
  post 'pets/add'
  post 'pets/remove'
  post 'pets/api'

  post 'api/favourite'

  get '/favourites' => 'api#all'

  post 'rating/sitter'

  devise_for :users
end
