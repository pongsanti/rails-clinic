require 'concerns/breadcrumb_helper'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # available as class and instance methods
  extend BreadcrumbHelper
  include BreadcrumbHelper

  include Pundit
  protect_from_forgery with: :exception
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  #bc  
  add_breadcrumb I18n.t("bc.home"), :root_path

  private
  	def set_locale
  	  I18n.locale = params[:locale] || I18n.default_locale
  	end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end
	
end