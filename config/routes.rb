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

  resources :books, only: [:index, :show] do
    resources :review_rates, except: :index
  end
  
  resources :users, except: :destroy
  resources :relationships, only: [:index, :create, :destroy]
  resources :categories, only: [:index, :show]
  resources :requests, except: [:show, :edit, :update]
end
