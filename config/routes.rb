Rails.application.routes.draw do
  get 'sessions/new'
  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :feeds do
    collection do
      post :confirm
    end
  end
end
