class JwtService

    def self.encode(payload,exp=24.hours.from_now)
        payload[:exp]=exp.to_i
        JWT.encode(payload,JWT_SECRET)
    end

    def self.decode(token)
        decoded=JWT.decode(token,JWT_SECRET)
    end
end