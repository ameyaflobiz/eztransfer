class Wallet < ApplicationRecord
  belongs_to :user
  enum currency_type: CURRENCIES
  scope :fetch_wallet, ->(params){ find_or_create_by(params)}
end
