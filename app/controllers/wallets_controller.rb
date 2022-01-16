class WalletsController < ApplicationController
    before_action :authorize_request

    def add_money_to_wallet
        # render json: @user.username
        wallet_type= CURRENCIES[params[:currency_type].to_sym]
        amount=params[:amount]
        @wallet= Wallet.find_or_create_by(user_id: @user.id,currency_type: wallet_type)
        @wallet=WalletService.add_money(@wallet.id,amount)
        render json: {message:"Wallet amount was successfully added",wallet: @wallet.wallet_amount, amount: params[:amount], wallet_type: params[:currency_type] }
    end

    def transfer_money
        # Call your service here
        wallet_type_sender = CURRENCIES[params[:sender_currency_type].to_sym]
        wallet_type_reciever = CURRENCIES[params[:reciever_currency_type].to_sym]

        WalletService.transfer(
                               params[:sender_id],
                               params[:reciever_id],
                               params[:sender_currency_type],
                               params[:reciever_currency_type],
                               params[:sender_amount]
                              )

        sender_wallet = Wallet.fetch_wallet( params[:sender_id], wallet_type_sender )
        reciever_wallet = Wallet.fetch_wallet( params[:reciever_id], wallet_type_reciever )

        render json: { sender_wallet: sender_wallet, reciever_wallet: reciever_wallet }
    end

    
end
