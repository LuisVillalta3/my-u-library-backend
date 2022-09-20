Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'auth#login'  
      resources :author, only: %i[index show create update destroy]
      resources :genres, only: %i[index show create update destroy]
      resources :books, only: %i[index show create update destroy]
      resources :roles, only: %i[index]
      resources :users, only: %i[index show create]
      resources :request_statuses, only: %i[index]
      resources :check_out_requests, only: %i[index create update]
    end
  end
end
