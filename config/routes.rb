Rails.application.routes.draw do
  root 'admin/sections#index'

  namespace :admin do
    resources :sections
  end

  # 모바일 전용 뷰 (브라우저로 바로 접속)
  namespace :mobile do
    root 'sections#index'
    resources :sections, only: [:index, :show]
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
