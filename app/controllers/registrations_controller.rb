class RegistrationsController < Devise::RegistrationsController

  def update
    if current_user.update(registration_params)
      redirect_to root_path, notice: t('successfully_updated')
    else
      render 'users/registrations/edit'
    end
  end

  def registration_params
    params[:user].permit(:display_name)
  end

end