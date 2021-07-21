Rails.application.routes.draw do
  root 'home#index'
  get 'home/show'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
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
  resources :admins
  resources :users do
    get :profile, on: :member
  end
  resources :mentors do
    get :profile, on: :member
  end
  resources :reservations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
