Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root to: 'homes#top'
    resources :items, only: [:index, :show]
      resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "all_destroy"
      end
    end
    resources :pre_orders, only: [:new, :index, :show, :create] do
      collection do
        post 'check'
        get 'over'
      end
    end
    resource :customers, only: [:show, :edit] do
      collection do
        get 'quit'
        patch 'out'
      end
    end
  end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
    resources :pre_orders, only: [:index, :show, :update] do
      resources :pre_order_details, only: [:update]
    end
  end
end
