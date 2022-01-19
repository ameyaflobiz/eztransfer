class Wallet < ApplicationRecord
  belongs_to :user
  enum currency_type: CURRENCIES
  scope :fetch_wallet, ->(user_id, currency_type){ find_or_create_by(user_id: user_id, currency_type: currency_type)}
end
