Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admins
  devise_for :users
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      mount ActionCable.server => '/cable'
      
      resources :users, module: :users, only: %i[create show] do
        resources :friend_requests, module: :friend_requests, only: %i[index create destroy] do
          put :accept, on: :member
        end
        
        resources :friends, module: :friends, only: %i[index destroy]
        
        resources :favorites, module: :favorites, only: %i[create destroy index]
        resource :favorites, module: :favorites, only: [] do
          resources :videos, only: :index
          resources :playlists, only: :index
        end
        
        resources :playlists, module: :playlists, only: %i[create destroy index] do
          put :toggle, on: :member
          resources :videos, module: :videos, only: %i[create destroy]
        end
      end
      
    end
  end
end
