class WalletsController < ApplicationController

    def add_money_to_wallet
    
        params[:user_id] = @user.id
        wallet = Wallet.fetch_wallet(wallet_params)
        amount = params[:amount]
       
        @wallet = WalletService.new().add_money(wallet.id,amount)

        render json: {message:"Wallet amount was successfully added",wallet: @wallet.wallet_amount, amount: params[:amount], wallet_type: params[:currency_type] }
    end

    def transfer_money

        transaction = WalletService.new().transfer_money(transfer_params)

        sender_wallet = Wallet.find_by(user_id: params[:sender_id], currency_type: params[:sender_currency_type] )
        reciever_wallet = Wallet.find_by(user_id: params[:reciever_id], currency_type: params[:reciever_currency_type] )
        
        render json: { transaction: transaction }
    end

    private

    def transfer_params
        params.permit(:sender_id, :reciever_id, :sender_currency_type, :reciever_currency_type, :sender_amount)
    end

    def wallet_params
        params.permit(:user_id,:currency_type)
    end
    
end
