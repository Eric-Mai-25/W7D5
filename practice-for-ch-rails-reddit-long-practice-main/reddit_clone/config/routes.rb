Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    resources :subs, only: [:edit, :update]
    resources :posts, only: [:edit,:update]
  end
  resource :session, only: [:new, :create, :destroy] 
  resources :subs, except: [:destroy] do
    resources :posts, only: [:show]
  end
  resources :posts, except: [:index, :destroy]
end
