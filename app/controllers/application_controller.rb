class ApplicationController < ActionController::Base
  # Ensure users are authenticated before accessing any page
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect users after sign-in based on their role
  def after_sign_in_path_for(resource)
    resource.admin? ? assign_admin_user_path(resource) : root_path
  end

  # Redirect users to the login page after signing out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  # Permit additional Devise parameters (first_name & last_name)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
