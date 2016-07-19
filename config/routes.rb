Rails.application.routes.draw do
  root 'advertisements#index'
  devise_for :users
  resources :advertisements do
    resources :reviews
  end
end
