Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html 
  post "/getOTP",:to => "users#getOTP"
  post "/login",:to => "users#login"
  resources :users
end
