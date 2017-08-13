Rails.application.routes.draw do

  get 'invoices/invoice_list'  => "invoices#invoice_list" 
  root to: 'invoices#index'
  devise_for :users
  resources :users
  resources :invoices
end
