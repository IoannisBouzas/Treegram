Rails.application.routes.draw do
  
  
  get '/' => 'home#index'
  resources :users do
    resources :photos
  end

  resources :photos, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :tags, only: [:create, :destroy]
  get '/log-in' => "sessions#new"
  post '/log-in' => "sessions#create"
  get '/log-out' => "sessions#destroy", as: :log_out

  post 'users/:id/follow' => 'users#follow', as: :follow_user

  resources :users do
    member do
      post 'follow'
      delete 'unfollow'
    end
  end


end




