class SessionsController < ApplicationController
    before_action :require_logged_in, only: [:destroy]
    def new
    end

    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ["Invalid username or password"]
            @username = params[:user][:username] # for prefill
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end
