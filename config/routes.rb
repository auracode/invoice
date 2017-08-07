Rails.application.routes.draw do
  
  root to: 'invoices#index'
  devise_for :users
  resources :users
  resources :invoices
end
