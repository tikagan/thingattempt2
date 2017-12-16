class SessionsController < ApplicationController

	def create
	user = User.find_by(email: params[:email])

		if user && user.autheticate(params[:password])
			session[:user_id] = user.user_id
			redirect_to root_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end
