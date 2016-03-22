Rails.application.routes.draw do
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

  root to: 'home#index'

  devise_for :users
end
