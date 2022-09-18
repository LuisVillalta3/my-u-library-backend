Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :author, only: %i[index show create update destroy]
      resources :genres, only: %i[index show create update destroy]
      resources :books, only: %i[index show create update destroy]
      resources :roles, only: %i[index]
      resources :users, only: %i[index show create]
      resources :request_statuses, only: %i[index]
    end
  end
end
