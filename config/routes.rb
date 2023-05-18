Rails.application.routes.draw do
  get 'users/edit'
  get 'users/show'
  get 'users/index'
  get 'books/edit'
  get 'books/show'
  get 'books/index'
  get 'homes/home'
  get 'homes/about'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
