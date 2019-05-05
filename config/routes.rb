Rails.application.routes.draw do

  get 'invoices/invoice_list'  => "invoices#invoice_list" 
  get 'invoices/invoice_list1718'  => "invoices#invoice_list1718" 
  get 'invoices/Q1' => "invoices#Q1"
  get 'invoices/Q2'=> "invoices#Q2"
  get 'invoices/Q3'=> "invoices#Q3"
  get 'invoices/Q4'=> "invoices#Q4"
  get 'invoices/list'=> "invoices#list"

  root to: 'invoices#index'
  devise_for :users
  resources :users
  resources :invoices do 
  get 'challan'  , on: :member	
  end 
end
