class UsersController < ApplicationController
    skip_before_action :authorize_request, only: [:create,:login,:index,:get_otp]
    before_action :find_user, only: [:login,:get_otp]

    def index
        raise ActiveRecord::RecordNotFound
        @users=User.all
        render json: @users, status: :ok
    end

    def create
        @user= User.new(user_params)
        if @user.save!
            token= JwtService.new().encode({user_id:@user.id})
            render json: {user:@user, token: token}, status: :created
        end
            
    end

    def destroy
        @user.destroy!
    end

    def get_otp
        render json: {otp: @user.otp_code , username: @user.username}
    end

    def login

        if @user && @user.authenticate(params[:password]) && @user.authenticate_otp(params[:otp].to_s,drift:60)
            token = JwtService.new().encode(user_id: @user.id)
            render json:{ token: token, message: "The OTP was valid & a JWT Token has been created and is valid for 24 hours .", username: @user.username}, status: :ok
        else
            render json: {error: "incorrect OTP"}, status: :unauthorized
        end
    end

    def show
        render json: @user, status: :ok
    end


    private

    def find_user
        @user= User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json:{ errors: 'User not found'}, status: :not_found
    end

    def user_params
        params.permit(:username,:password)
    end
end
