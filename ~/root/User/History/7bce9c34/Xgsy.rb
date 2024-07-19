class UsersController < ApplicationController
    before_action, only: [:auto_login]

    def create
        @user = User.create(user_params)

        if @user.valid?
            token = encode_token(user_id: @user.id)
            render json: {user: @user, token: token}
        else
            render json: {error: "Invalid username or password."}
        end
    end

    def login 
        @user =User.find_by(username: params[:username])
        if @user.present? && @user.authenticate(params[:password])
            token = encode_token(user_id: @user.id)
            render json: { user: @user, token: token }
end
