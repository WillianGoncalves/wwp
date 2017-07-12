class HasLastGroupConstraint
  def matches?(request)
    user = User.find_by_id(request.session["warden.user.user.key"][0][0])
    user.last_group.present?
  end
end

Rails.application.routes.draw do
  devise_for :users

  root 'groups#index'

  resources :groups do
    member do
      get 'candidates'
    end
    resources :members, only: [:create]
    resources :join_requests, only: [:index, :create]
  end

  resources :join_requests, only: [] do
    member do
      put :accept
      put :reject
    end
  end

  get '/groups', to: 'groups#show', constraints: HasLastGroupConstraint.new
end
