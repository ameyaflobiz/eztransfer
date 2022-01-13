class WalletsController < ApplicationController
    before_action :authorize_request

    def add_money_to_wallet
        # render json: params
        wallet_type= CURRENCIES[params[:currency_type].to_sym]
        amount=params[:amount]
        @wallet= Wallet.find_or_create_by(user_id: @user.id,currency_type: wallet_type)
        @wallet=WalletService.add_money(@wallet.id,amount)
        render json: {message:"Wallet amount was successfully added",wallet: @wallet.wallet_amount, amount: params[:amount], wallet_type: params[:currency_type] }
    end

    
end
