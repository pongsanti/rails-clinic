require 'concerns/breadcrumb_helper'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # available as class and instance methods
  extend BreadcrumbHelper
  include BreadcrumbHelper

  # Pundit
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  protect_from_forgery with: :exception
  before_action :set_locale


  #bc  
  add_breadcrumb I18n.t("bc.home"), :home_path

  private
  	def set_locale
  	  I18n.locale = params[:locale] || I18n.default_locale
  	end

    # Pundit
    def user_not_authorized
      flash[:alert] = I18n.t("not_authorized")
      redirect_to(request.referrer || home_path)
    end

    # Devise
    # You can override the default behaviour by creating an after_sign_in_path_for 
    def after_sign_in_path_for(resource)
      home_path
    end

    # Devise
    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
	
end