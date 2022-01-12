class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.integer :currency_type
      t.decimal :wallet_amount, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
