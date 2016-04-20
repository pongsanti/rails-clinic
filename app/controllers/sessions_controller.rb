class SessionsController < ApplicationController
  def new
  end

  def create
  	p = session_params
  	user = User.authenticate(p[:email], p[:password])
  	if user
  		session[:user_id] = user.id
  		flash[:notice] = "Logged in!"
  		redirect_to action: 'new', controller: 'users'
  	else
  		flash.now.alert = "Invalid email or password"
  		render "new"
  	end
  end

  private

  def session_params
  	params.permit(:email, :password)
  end
end
