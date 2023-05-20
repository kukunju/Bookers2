Rails.application.routes.draw do
  root to: "homes#home"
  devise_for :users
  get 'homes/about'




  resources :books, only: [:edit, :show , :index , :create, :destroy]
  resources :users, only: [:edit, :show , :index ,:update]



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
