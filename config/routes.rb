Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users

    resources :lists, except: [:new, :edit] do
      resources :items, only: [:create]
    end

    resources :items, only: [:destroy]
  end
end
