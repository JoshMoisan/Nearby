Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

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
