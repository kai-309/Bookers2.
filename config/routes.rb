Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  #検索ボタンが押された時,Searchesコントローラーのsearchアクションが実行できるように定義
  get '/search', to: 'searches#search'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
   resources :book_comments, only: [:create,:destroy]
   resource :favorites, only: [:create,:destroy]
  end

  #フォロー・フォロワー
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers',as: 'followers'
  end
end
