class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:twitter_username, :website])
  end

  def require_admin_or_ownership!(object)
    if user_signed_in? && (current_user.admin? || current_user.owns?(object))
      true
    else
      head :forbidden
    end
  end
end
