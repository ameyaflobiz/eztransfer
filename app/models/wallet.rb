class Wallet < ApplicationRecord
  belongs_to :user
  enum currency_type: { INR: 0, USD: 1, YEN: 2, EURO: 3, CHF: 4 }
end
