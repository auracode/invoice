Rails.application.routes.draw do

  get 'invoices/invoice_list'  => "invoices#invoice_list" 
  get 'invoices/invoice_list1718'  => "invoices#invoice_list1718" 
  
  root to: 'invoices#index'
  devise_for :users
  resources :users
  resources :invoices do 
  get 'challan'  , on: :member	
  end 
end
