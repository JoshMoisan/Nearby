Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/new'
  get 'reviews/create'
  get 'bookings/index'
  get 'bookings/create'
  get 'bookings/new'
  get 'bookings/show'
  get 'bookings/update'
  get 'bookings/destroy'
  devise_for :users
  root to: "items#index", as: :home

  resources :users, only: %i[show edit], shallow: true do
    resources :items do
      resources :bookings, except: %i[edit]
    end
  end

  resources :bookings, only: %i[] do
    resources :reviews, only: %i[index new create]
  end

  resources :reviews, only: %i[destroy]
end
