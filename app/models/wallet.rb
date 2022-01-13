class Wallet < ApplicationRecord
  belongs_to :user
  enum currency_type: CURRENCIES
end
