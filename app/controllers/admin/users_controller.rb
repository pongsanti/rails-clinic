class Admin::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_ransack_search_param, only: [:index, :edit, :update]
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def index
    @users = @q.result.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: t("successfully_updated")
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit( roles:[] )
    end

    def set_ransack_search_param
      @q = User.ransack(params[:q])
    end

    def set_user
      @user = User.find(params[:id])
    end
end
