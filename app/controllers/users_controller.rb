class UsersController < ApplicationController
    def index
        @users = User.all  
    end

    def create
        @user = User.new(user_params)
        if @user.save
            title[:user_id] = @user.id
            redirect_to "/dashboard"
        else
            flash[:register_errors] = @user.errors.full_messages
            redirect_to "/"
        end
    end
    
    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to "/dashboard"
        else            
            flash[:login_errors] = ["Invalid email or password"]
            redirect_to "/"
        end
    end

    def logout
        session.clear
        redirect_to "/"
    end
    
    def dashboard
        @user = User.find(session[:user_id])
        @forms = Form.where(user_id: @user.id)
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to "/dashboard"
        else
            flash[:edit_errors] = @user.errors.full_messages
            redirect_to "/"
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to "/"
    end





    
   private
   def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
