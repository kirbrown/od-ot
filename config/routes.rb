Rails.application.routes.draw do

  root 'pages#home'

  get '/sign_in' => 'user_sessions#new', as: :sign_in
  get '/sign_up' => 'users#new', as: :sign_up
  delete '/sign_out' => 'user_sessions#destroy', as: :sign_out

  resources :users, except: [:show]
  resources :user_sessions, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :todo_lists do
    put :email, on: :member
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end

end
