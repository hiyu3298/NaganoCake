class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
        admin_root_path
    when Customer
        customer_path(current_customer)
    end
  end

  # def after_sign_out_path_for(resource)
  #   case resource
  #   when Admin
  #       new_admin_session_path
  #   when Customer
  #       new_customer_session_path
  #   end
  # end

  # application_controllerでの記述でログアウト先がうまく遷移されないため
  # sessions_controllerに直接記述

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
    end
end
