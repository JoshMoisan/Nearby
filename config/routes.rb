Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home", as: :home

  resources :users, only: %i[show edit], shallow: true do
    resources :items do
      resources :bookings, except: %i[edit]
    end
  end

  resources :bookings, only: %i[] do
    resources :reviews, only: %i[index new create]
  end

  resources :reviews, only: %i[destroy]
  resources :items, only: %i[index]


  # CHAT
  resources :chatrooms, only: [:show, :create] do
    resources :messages, only: :create
  end
end
