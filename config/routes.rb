Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
  post "/getOTP",:to => "users#getOTP"
  post "/login",:to => "users#login"
  resources :users 
  resources :wallets ,except: [:create]
  post "/transfer_money", :to => "wallets#transfer_money"
  post "/add_money_to_wallet",:to => "wallets#add_money_to_wallet"

end
