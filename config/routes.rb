Rails.application.routes.draw do
  root to: 'questions#index'
  resources :questions, only: [:index]
end
