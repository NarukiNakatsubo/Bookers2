Rails.application.routes.draw do

  devise_for :users
  
  # deleteメソッドが自動で設定されているはずだが遷移しないので直接設定
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # resources :users, only: [:show, :edit]
  resources :books
  resources :users
  
  # ネスとしている
  # resourceの単数形はidがURLに含まれなくなる
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  root to: "home#top"
  get '/home/about', to: 'home#about'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
