class CompaniesController < ApplicationController
    before_action :load_company, only: [:show, :edit, :update]
    before_action :authenticate_company_admin, only: [:edit, :update]

    def index
        @companies = Company.all
    end

    def show

    end

    def edit 

    end
    
    def update
      if @company.update(company_params)
       redirect_to recruiters_path
      else
        render 'edit'
      end
    end

    private 
    
    def load_company
      @company = Company.find(params[:id])
    end

    def authenticate_company_admin
      current_recruiter&.admin? && current_recruiter.company == @company
    end

    def company_params
      params.require(:company).permit(:name, :address, :cnpj, :domain, :website, :logo, :about)
    end

end 