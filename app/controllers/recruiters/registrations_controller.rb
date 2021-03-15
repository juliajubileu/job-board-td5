# frozen_string_literal: true

class Recruiters::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create 
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  def cancel
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[attribute
                                                                company_id])
  end

  def after_sign_up_path_for(resource)
    if resource.admin?
      edit_company_path(resource.company_id)
    else
      recruiters_path
    end
  end
end
