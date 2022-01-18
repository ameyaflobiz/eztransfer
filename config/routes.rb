Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
  require "sidekiq/web"
  mount Sidekiq::Web=>"/sidekiq"


  resources :users do 

      member do
        post :get_otp
        post :login
      end

  end
  resources :wallets ,except: [:create,:update] do 
    
    collection do
      post :transfer_money
      post :add_money_to_wallet
    end

  end


end
