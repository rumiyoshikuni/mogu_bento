Rails.application.routes.draw do

  # 会員用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲストユーザーをログイン状態にする
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/customers/sessions#guest_sign_in'
    get 'customers', to: 'public/registrations#index'
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :items, only: [:index, :show]
      resource :customers,only: [] do
      get "my_page"=>"customers#show"
      get "information/edit"=>"customers#edit"
      patch "information"=>"customers#update"
      get "quit"
      patch "out"
    end
      resources :cart_items, only: [:index, :create, :update, :destroy] do
        collection do
          delete "all_destroy"
      end
    end
    resources :pre_orders, only: [:new, :index, :show, :create, :destroy] do
      collection do
        post "check"
        get "over"
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
    get "pre_orders" => "homes#top"
    resources :pre_orders, only: [:show]
    resources :pre_order_details, only: [:update]
  end
end
