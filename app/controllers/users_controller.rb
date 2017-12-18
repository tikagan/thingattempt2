class UsersController < ApplicationController
  before_action :clearbit_auth, only: [:get_user_info]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render :new
    end
  end

  def get_user_info
    email =  params[:email] + '.' + params[:format]
    response = Clearbit::Enrichment.find(email:  email, stream: true)

    if response == nil
      render body: nil, :status => :not_found
    else
      render :json => response
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :full_name,:phone_number, :company_size, :company_name, :password)
  end

  def clearbit_auth
    Clearbit.key = ENV['CBIT_API']
  end

end