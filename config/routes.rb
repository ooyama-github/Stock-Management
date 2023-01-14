Rails.application.routes.draw do

# 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # 管理者のトップページ
  get '/admin' => 'admin/homes#top'
  
  

  #顧客のトップページ、アバウトページの遷移
  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'
  
   # 顧客のマイページ、編集画面、退会画面
  scope module: :public do
    get 'customers/mypage' => 'customers#show', as: 'customers_mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'customers_edit'
    get 'unsubscribe' => 'customers#unsubscribe', as: 'customers_unsubscribe'
    patch 'customers/information' => 'customers#update', as: 'customers_update'
    patch 'withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    resources :items, only: [:new, :index, :show, :edit, :create, :update, :destroy]
    resources :genres, only: [:index,:create,:edit,:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
