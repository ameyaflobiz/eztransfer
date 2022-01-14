module Error
    module ErrorHandler #modules are generally used for name
        def self.included(klass)

=begin
whatever class which includes the Error:ErrorHandler is evaluated as klass 
( in this case it is the Application Controller itself )where we have
added rescue_from allowing us to rescue exceptions from any controller
=end
            
            klass.class_eval do

                rescue_from Error::Exceptions::CustomException do |e|
=begin
In CustomException class, we use attribute reader(coz we don't need write operations
in this class) so that we can use their values here like e.error and so on..
=end
                    respond( e.error, e.status, e.message)
                end
            end

        end

        private

        def respond( _error, _status, _message)
            
# We are calling a helper method to render the error in a json format for convenience
            json= Helpers::Render.json( _error, _status, _message)
            render json: json

        end
    end
end