Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions, only: [:index, :new, :create] do
    collection do
      get 'japanese'
    end
    collection do
      get 'math'
    end
    collection do
      get 'english'
    end
  end
end
