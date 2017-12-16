class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  	if session[:user_id]
  		return User.find(Session[:user_id])
  	end
end

helper_method :current_user
end
