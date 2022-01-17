class WalletsController < ApplicationController
    before_action :authorize_request

    def add_money_to_wallet
    
        
        wallet = Wallet.fetch_wallet(@user.id, params[:currency_type])
        amount = params[:amount]
       
        @wallet = WalletService.new().add_money(wallet.id,amount)

        render json: {message:"Wallet amount was successfully added",wallet: @wallet.wallet_amount, amount: params[:amount], wallet_type: params[:currency_type] }
    end

    def transfer_money
        # Call your service here no need


        @transaction = WalletService.new().transfer_money(transfer_params)

        sender_wallet = Wallet.find_by(user_id: params[:sender_id], currency_type: params[:sender_currency_type] )
        reciever_wallet = Wallet.find_by(user_id: params[:reciever_id], currency_type: params[:reciever_currency_type] )
        
        render json: { transaction: @transaction }
    end

    private

    def transfer_params
        params.permit(:sender_id, :reciever_id, :sender_currency_type, :reciever_currency_type, :sender_amount)
    end
    
end
