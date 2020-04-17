Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admins
  devise_for :users
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users, module: :users, only: %i[create show] do
        resources :favorites, module: :favorites, only: %i[create destroy index]
        resources :playlists, module: :playlists, only: %i[create destroy index] do
          resources :videos, module: :videos, only: %i[create destroy]
        end
      end
      
    end
  end
end
