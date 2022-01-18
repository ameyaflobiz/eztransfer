
class Error::Exceptions::CustomException < StandardError

    attr_reader :status, :message

    def initialize(status = nil, message = nil )
        @status = status
        @message = message || "Something went wrong"
    end

    
end
