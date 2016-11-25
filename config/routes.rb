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
    resources :requests, except: [:new, :create, :show]
  end

  resources :books, only: [:index, :show] do
    resources :review_rates, except: :index
    resources :book_marks, only: [:update, :create, :edit]
  end
  resources :review_rates, except: :index do
    resources :comments, except: [:index, :show]
  end
  
  resources :users, except: :destroy
  resources :relationships, only: [:index, :create, :destroy]
  resources :categories, only: [:index, :show]
  resources :requests, except: [:show, :edit, :update]
end
