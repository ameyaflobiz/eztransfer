class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', required: true
  belongs_to :reciever, class_name: 'User', foreign_key: 'reciever_id', required: true
  
  currencies=  { INR: 0, USD: 1, YEN: 2, EURO: 3, CHF: 4 }
  enum sender_currency_type: currencies,_prefix:true
  enum reciever_currency_type: currencies,_prefix:true
  enum transaction_status: {in_progress:0,success:1,fail:2}
end
