Rails.application.routes.draw do

  root "pages#show", page: "home"
  get "/pages/*page" => "pages#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :categories, except: :show do
      resources :books
    end  
  end
  
  resources :users, except: [:destroy]
  resources :categories, only: [:index, :show]
  resources :books, only: [:index, :show]
end
