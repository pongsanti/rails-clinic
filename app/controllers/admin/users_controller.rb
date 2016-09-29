class Admin::UsersController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, :notice => "Signed up!"
    else
      render "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
