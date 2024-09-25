class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image])
  end
end
