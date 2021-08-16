# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "home/show"
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    passwords: "admins/passwords",
    registrations: "admins/registrations"
  }
  devise_for :mentors, controllers: {
    sessions: "mentors/sessions",
    passwords: "mentors/passwords",
    registrations: "mentors/registrations"
  }
  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }
  resources :admins do
    get :home, on: :collection
  end
  resources :users do
    get :profile, on: :member
    get :home, on: :collection
  end
  resources :mentors do
    get :profile, on: :member
    get :home, on: :collection
  end
  resources :reservations do
    put :accept_reservation, on: :member
  end
  resources :calendars
  resources :attendances
  resources :events do
    post :join_to_event, on: :member
    delete :undo_from_event, on: :member
  end
  resources :clubs do
    post :join_to_club, on: :member
    delete :undo_from_club, on: :member
  end
  resources :mentor_settings
  resources :temporary_schedules do
    get :schedule_of_mentor, on: :member
    put :create_reservation, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
