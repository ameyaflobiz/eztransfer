class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :sender_amount
      t.decimal :reciever_amount
      t.integer :sender_currency_type
      t.integer :reciever_currency_type
      t.integer :transaction_status, default: 0
      t.references :sender, null: false, foreign_key: {to_table: :users}
      t.references :reciever, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
