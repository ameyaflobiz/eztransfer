class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'User', required: true
  belongs_to :reciever, class_name: 'User', required: true
  
  enum sender_currency_type: CURRENCIES
  enum reciever_currency_type: CURRENCIES, _prefix: true
  enum transaction_status: { in_progress: 0, success: 1, failed: 2 }
end
