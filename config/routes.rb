Rails.application.routes.draw do
  root 'home#index'
  get 'home/show'
  devise_for :mentors, controllers: {
    sessions: 'mentors/sessions',
    passwords: 'mentors/passwords',
    registrations: 'mentors/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :users, only: [:index]
  resources :mentors, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
