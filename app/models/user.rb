class User < ApplicationRecord
    has_secure_password
    has_one_time_password
    has_many :transactions,->(user) { unscope(where: :sender_id).where("sender_id = ? OR reciever_id = ?", user.id, user.id) }, foreign_key: :sender_id
    has_many :wallets

    validates :username, presence: true,uniqueness: true
    validates :password, length: { in: 6..20 }
end
