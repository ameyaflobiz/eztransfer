module Error::Exceptions
    class NotVisibleException < CustomException

    #Overriding this class' initialize with the initialize of method of it's superclass
        def initialize
            super( :you_cant_see_me, 422, "You can't see me" )
        end
        
    end
end