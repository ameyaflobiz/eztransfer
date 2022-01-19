class WalletsController < ApplicationController

    def add_money_to_wallet
    
        @wallet = WalletService.new().add_money(add_money_to_wallet_params)

        render json: {message:"Wallet amount was successfully added",wallet: @wallet.wallet_amount, amount: params[:amount], wallet_type: params[:currency_type] }
    end

    def transfer_money

        transaction = WalletService.new().transfer_money(transfer_params)
        
        render json: { transaction: transaction }
    end

    private

    def transfer_params
        params.permit(:sender_id, :reciever_id, :sender_currency_type, :reciever_currency_type, :sender_amount)
    end

    def add_money_to_wallet_params
        params.permit(:user_id,:currency_type,:amount).merge(user_id: @user.id)
    end
    
end
