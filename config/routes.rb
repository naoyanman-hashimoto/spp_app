Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :answers, only: [:new, :create] do
      resources :scores, only: [:index, :new, :create]
    end
    collection do
      get 'genre'
    end
  end
end
