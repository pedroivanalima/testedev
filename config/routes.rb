Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "schedule#index"

  resources :schedule do 
    get :detail, on: :member
  end
end
