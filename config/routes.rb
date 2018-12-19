Rails.application.routes.draw do
  devise_for :users

  root 'groups#index'

  resources :groups, except: [:destroy] do
    member do
      get 'candidates'
    end
    resources :members, only: [:create, :destroy]
    resources :join_requests, only: [:index, :create]
    resources :songs do
      collection do
        get 'authors'
      end
    end
    resources :tags, except: [:new, :show]
    resources :presentations
  end

  resources :songs, only: [] do
    resources :comments, only: [:create]
  end

  resources :presentations, only: [] do
    resources :comments, only: [:create]
    member do
      get 'play'
    end
  end

  resources :comments, only: [:update, :destroy]

  resources :join_requests, only: [] do
    member do
      put :accept
      put :reject
    end
  end

  resources :colors, only: [:index]
end
