class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_ransack_search_param, only: [:index, :edit, :update]
  before_action :set_user, only: [:edit, :update, :destroy]

  #bc
  add_breadcrumb bc(:list, User), :users_path

  def index
    authorize(:user)

    @users = User.for_client(current_user.client)
  end

  def edit
    authorize(@user)
    add_bc :edit, edit_user_path(@user)

  end

  def update
    authorize(@user)

    if @user.update(user_params)
      redirect_to users_url, notice: t("successfully_updated")
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:display_name, :role)
    end

    def set_ransack_search_param
      @q = User.ransack(params[:q])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def add_bc(key, path)
      add_breadcrumb bc(key, User), path
    end
end
