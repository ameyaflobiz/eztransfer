class WalletService
    def self.add_money(wallet_id,amount)

        ActiveRecord::Base.transaction do
            @wallet=Wallet.find(wallet_id)
            amount=amount.to_i
            @wallet.update!(wallet_amount: @wallet.wallet_amount+amount)
        end
        @wallet
    end

    def self.transfer
    end
end