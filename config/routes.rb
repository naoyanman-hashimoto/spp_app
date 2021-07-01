Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions, only: [:index, :new, :create, :edit, :update] do
    resources :answers, only: [:new, :create]
    collection do
      get 'genre'
    end
  end
end
