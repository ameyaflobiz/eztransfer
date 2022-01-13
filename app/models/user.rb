class User < ApplicationRecord
    has_secure_password
    has_one_time_password

    validates :username, presence: true
    validates :password, length: { in: 6..20 }
    
    has_many :transactions,->(user) { unscope(where: :user_id).
                    where("sender_id = ? OR reciever_id = ?", user.id, user.id) }
    has_many :wallets
    has_many :deposits, class_name: "Transaction", foreign_key: "reciever_id"
    has_many :withdrawls, class_name: "Transaction", foreign_key: "sender_id"
    
    # Verify if eager loading works or not 
    # def transactions
    #     Transaction.where("sender_id = ? OR reciever_id = ?", id, id) }
    # end

end
