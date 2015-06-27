Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users

    resources :lists, only: [:create, :destroy] do
      resources :items, only: [:create]
    end

    resources :items, only: [:destroy]
  end
end
