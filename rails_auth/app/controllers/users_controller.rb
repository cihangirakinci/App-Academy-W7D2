class UsersController < ApplicationController
    def new  #GET gets the form
        user = User.new
        render :new
    end

    def create #POST creates the user based on the params from the form
        @user = User.new(user_params)

        if @user.save 
            redirect_to user_url
        else
            render :new, status: 422
        end
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

end
