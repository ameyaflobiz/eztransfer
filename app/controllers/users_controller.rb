class UsersController < ApplicationController
    before_action :authorize_request, except: [:create,:login,:index,:getOTP]
    before_action :find_user, only: [:login,:getOTP]
    def index
        @users=User.all
        render json: @users, status: :ok
    end

    def show
        render json: @user, status: :ok
    end

    def getOTP
        render json: {otp: @user.otp_code , username: @user.username}
    end
    def login

        if @user && @user.authenticate(params[:password]) && @user.authenticate_otp(params[:otp].to_s,drift:60)
            token = JwtService.encode(user_id: @user.id)
            render json:{ token: token, message: "The OTP was valid & a JWT Token has been created and is valid for 24 hours .", username: @user.username}, status: :ok
        else
            render json: {error: "incorrect OTP"}, status: :unauthorized
        end
    end
    def create
        @user= User.new(user_params)
        if @user.save
            token= JwtService.encode({user_id:@user.id})
            render json: {user:@user, token: token}, status: :created
        else
            render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
        end
            
    end

    def update

        unless @user.update(user_params)
            render json:{ errors: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy!
    end
    private

    def find_user
        @user= User.find_by_username(params[:username])
    rescue ActiveRecord::RecordNotFound
        render json:{ errors: 'User not found'}, status: :not_found
    end

    def user_params
        params.permit(:username,:password)
    end
end
