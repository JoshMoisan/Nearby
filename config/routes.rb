Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home", as: :home

  resources :users, only: %i[show edit], shallow: true do
    resources :items do
      resources :bookings, except: %i[edit] do
        resources :review, only: %i[index new create]
      end
    end
  end

  # resources :bookings, only: %i[] do
  #   resources :reviews, only: %i[index new create]
  # end

  resources :reviews, only: %i[destroy]
  resources :items, only: %i[index]

  resources :users, only: :show do
    resources :showtools, only: :show
  end


  # CHAT
  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: :create
  end
end
