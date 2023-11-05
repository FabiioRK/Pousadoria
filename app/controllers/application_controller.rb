class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_host_registration, unless: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_type])
  end

  def check_host_registration
    if user_signed_in?
      user = current_user
      if user.account_type == "host" && !user.inn.present? && request.path != new_inn_path
        redirect_to new_inn_path, notice: 'Você deve cadastrar a sua pousada.'
      end
    end
  end

end
