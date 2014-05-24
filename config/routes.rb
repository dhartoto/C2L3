PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get  '/register', to: 'users#new', as: 'register'
  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'


  resources :posts, except: :destroy do
    resources :comments, only: :create
  end
  resources :categories, except: :destroy
  resources :users, only: [:create, :edit, :update, :show]
end