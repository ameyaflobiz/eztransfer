class AddLockVersionToWallets < ActiveRecord::Migration[6.0]
  def change
    add_column :wallets, :lock_version, :string
  end
end
