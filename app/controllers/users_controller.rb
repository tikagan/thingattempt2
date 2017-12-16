class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:user_id])
  end

  # GET /users/new
  def new
    @user = User.new
  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
    else
      render :new 
    end
  end

  private
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :role, :company_name, :password)
    end
end
