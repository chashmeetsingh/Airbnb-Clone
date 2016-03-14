Rails.application.routes.draw do
  get 'home/index'

  get 'dog/index'

  post 'dog/add'

  post 'dog/remove'

  root to: "home#index"

  devise_for :users
end
