class WalletService
    def self.add_money( wallet_id, amount )

        ActiveRecord::Base.transaction do
            @wallet = Wallet.find(wallet_id)
            amount = amount.to_d.round(AMOUNT_PRECISION)
            @wallet.update!(wallet_amount: @wallet.wallet_amount + amount)
        end
        @wallet
    end

    def self.transfer( sender_id, reciever_id, sender_currency_type, reciever_currency_type, sender_amount )

        wallet_type_sender = CURRENCIES[sender_currency_type.to_sym]
        wallet_type_reciever = CURRENCIES[reciever_currency_type.to_sym]

        sender_wallet = Wallet.fetch_wallet( sender_id, wallet_type_sender )
        reciever_wallet = Wallet.fetch_wallet(reciever_id, wallet_type_reciever )
        sender_amount = sender_amount.to_d.round(AMOUNT_PRECISION)
        
        ActiveRecord::Base.transaction do
            if sender_amount <= sender_wallet.wallet_amount
                # fetch conversion rate from redis (make a service)
                reciever_amount = ConversionService.convert(sender_currency_type,reciever_currency_type,sender_amount)
                reciever_amount = reciever_amount.round(AMOUNT_PRECISION)
                
                # After this gets done, update wallet of both parties

                sender_wallet.update!(wallet_amount: ( sender_wallet.wallet_amount-sender_amount ))
                reciever_wallet.update!(wallet_amount: ( reciever_wallet.wallet_amount+reciever_amount ))
    
                # Finally, insert transaction record to transaction table
                Transaction.create!(
                                    sender_id: sender_id,
                                    reciever_id: reciever_id,
                                    sender_currency_type: wallet_type_sender,
                                    reciever_currency_type: wallet_type_reciever,
                                    sender_amount: sender_amount,
                                    reciever_amount: reciever_amount
                                   )

            else
                # I'll raise my own error here
                raise Error::Exceptions::InsufficientFundsException
            end
        end
    end

    private

end