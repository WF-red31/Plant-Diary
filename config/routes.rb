Rails.application.routes.draw do
  get 'posts/edit'
  devise_for :users
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'
  resources :users, only: [:show, :edit]
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
