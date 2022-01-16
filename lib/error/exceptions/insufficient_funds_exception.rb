module Error::Exceptions
    class InsufficientFundsException < CustomException

        def initialize
            super(:insufficent_funds,500,"Sender has insufficent funds to carry out the transaction.")
        end

    end
end