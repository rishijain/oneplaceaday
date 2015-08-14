class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :current_role

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :username
    end

    def current_role
      if user_signed_in?
        @current_role = current_user.role
      else
        @current_role = nil
      end
      @current_role
    end
end
