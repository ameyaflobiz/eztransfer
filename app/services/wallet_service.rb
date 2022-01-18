class WalletService
    def add_money( wallet_id, amount )

        @wallet = Wallet.find(wallet_id)
        amount = amount.to_d.round(AMOUNT_PRECISION)
        @wallet.update!(wallet_amount: @wallet.wallet_amount + amount)
        @wallet

    end

    def transfer_money(params)

        sender_amount=params[:sender_amount]
        sender_currency_type = params[:sender_currency_type]
        reciever_currency_type = params[:reciever_currency_type]
        sender_id = params[:sender_id]
        reciever_id=params[:reciever_id]


        sender_wallet = Wallet.find_by(user_id: sender_id, currency_type: sender_currency_type )
        reciever_wallet = Wallet.find_by(user_id: reciever_id, currency_type: reciever_currency_type )

        sender_amount = sender_amount.to_d.round(AMOUNT_PRECISION)
        
        # fetch conversion rate from redis (make a service)

        reciever_amount = ConversionService.new().convert(sender_currency_type,reciever_currency_type,sender_amount)
        reciever_amount = reciever_amount.round(AMOUNT_PRECISION)
        params["reciever_amount"] = reciever_amount

        ActiveRecord::Base.transaction do

            if sender_amount <= sender_wallet.wallet_amount
                      
                # After this gets done, update wallet of both parties (used optimistic locking here)
                
                sender_wallet.update!(wallet_amount: ( sender_wallet.wallet_amount-sender_amount ))
                reciever_wallet.update!(wallet_amount: ( reciever_wallet.wallet_amount+reciever_amount ))
    
                # Finally, insert transaction record to transaction table
                
                params["transaction_status"]="success"
                @transaction = Transaction.create!(params)


            else
                # I'll raise my own error here
                # Make a failing transaction here
                params["transaction_status"]="failed"
                @transaction = Transaction.create!(params)

                # When we raise the error, transaction doesn't gets created (ROLLBACK HOTA HAI)

                # raise Error::Exceptions::InsufficientFundsException

            end
        end

        # SIDEKIQ NOTIFY 

    end
end