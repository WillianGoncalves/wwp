class HasLastGroupConstraint
  def matches?(request)
    user = User.find_by_id(request.session["warden.user.user.key"][0][0])
    user.last_group.present?
  end
end

Rails.application.routes.draw do
  devise_for :users

  root 'groups#index'

  resources :groups, only: [:index, :show, :new, :create] do
    member do
      get 'candidates'
    end
    resources :members, only: [:create, :destroy]
    resources :join_requests, only: [:index, :create]
    resources :songs
    resources :tags, except: [:new, :show]
    resources :presentations
  end

  resources :songs, only: [] do
    resources :comments, only: [:create, :update, :destroy]
  end

  resources :presentations, only: [] do
    resources :comments, only: [:create, :update, :destroy]
    member do
      get 'play'
    end
  end

  resources :join_requests, only: [] do
    member do
      put :accept
      put :reject
    end
  end

  resources :colors, only: [:index]

  get '/groups', to: 'groups#show', constraints: HasLastGroupConstraint.new
end
