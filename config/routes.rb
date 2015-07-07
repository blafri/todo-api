Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users

    resources :lists, except: [:new, :edit] do
      resources :items, shallow: true, only: [:create, :destroy, :update]
    end
  end
end
