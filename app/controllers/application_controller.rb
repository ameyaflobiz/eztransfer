class ApplicationController < ActionController::API
    include Error::ErrorHandler
    
    def authorize_request
        auth_header= request.headers['Authorization']
        token= auth_header.split(' ')[1]
        begin
            @decoded= JwtService.decode(token)
            @user= User.find(@decoded[0]['user_id'])
        
        rescue ActiveRecord::RecordNotFound => error
            render json: { errors: error.message },status: :unauthorized
        rescue JWT::DecodeError => error
            render json: {errors: error.message }, status: :unauthorized
        end
    end
end
