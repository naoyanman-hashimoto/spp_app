Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions, only: [:index, :new, :create] do
    collection do
      get 'genre'
    end
  end
end
