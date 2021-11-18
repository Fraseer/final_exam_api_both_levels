Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/api'
  namespace :api do
    resources :articles, only: [:index, :show]
    resources :comments, only: [:create]
  end
end
