class RegistrationsController < Devise::RegistrationsController
    protected
  
    def after_sign_up_path_for(resource)
      domain = resource.email.split('@').last
      company = Company.find_by_domain(domain) 

      if company
        company_path(company)
      else 
        :new_company
      end
    end
  end