class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_user_abilities

  # include CanCanCan::ControllerAdditions # Add CanCanCan support

  protected

  # Configure permitted parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  # Load user abilities using CanCanCan
  def load_user_abilities
    @user_abilities ||= Ability.new(current_user)
  end
end
