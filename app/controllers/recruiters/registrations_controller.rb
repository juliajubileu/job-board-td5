# frozen_string_literal: true

class Recruiters::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create 
    if company_is_registered
      assign_company
      super
    else
      redirect_to new_company_path
    end
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :company_id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :company_id])
  end

  def after_sign_up_path_for(resource)
    recruiters_path
  end

  private

  def company_is_registered
    domain = params[:recruiter][:email].split('@').last
    company = Company.find_by(domain: domain)
  end

  def assign_company
    domain = params[:recruiter][:email].split('@').last
    company = Company.find_by(domain: domain)
    params[:recruiter][:company_id] = company.id
  end
end
