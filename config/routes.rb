Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
  require "sidekiq/web"
  mount Sidekiq::Web=>"/sidekiq"

  post "/get_otp",:to => "users#get_otp"
  post "/login",:to => "users#login"
  resources :users 
  resources :wallets ,except: [:create,:update]

  post "/transfer_money", :to => "wallets#transfer_money"
  post "/add_money_to_wallet",:to => "wallets#add_money_to_wallet"

end
