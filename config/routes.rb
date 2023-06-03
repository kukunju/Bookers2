Rails.application.routes.draw do

  root to: "homes#home"
  devise_for :users
  get '/home/about', to: 'homes#about'
  get 'search' => 'searches#search'




  resources :books, only: [:edit, :show , :index , :create, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:edit, :show , :index ,:update] do
    resources :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
