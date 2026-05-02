Rails.application.routes.draw do
  root 'admin/sections#index'

  namespace :admin do
    resources :sections
  end

  namespace :api do
    namespace :v1 do
      resources :sections, only: [:index, :show] do
        collection do
          get :sync
        end
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
