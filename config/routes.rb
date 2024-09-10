Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    resources :dashboards, only: [:index, :show]
    resources :users, only: [:destroy]
    resources :posts, only: [:destroy]
    resources :comments, only: [:destroy]
    get 'post_show/:id' => 'dashboards#post_show'
  end
  
  scope module: :public do
    get 'posts/edit'
    devise_for :users
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    resources :users, only: [:show, :edit, :update, :destroy, :index]
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
  
    get 'search' => 'searches#search'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
