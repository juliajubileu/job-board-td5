class CompaniesController < ApplicationController
    before_action :load_company, only: [:show, :edit, :update]
    before_action :authenticate_recruiter!, only: [:edit, :update]
    # TODO reorganizar o fluxo de cadastro de novo recrutador + empresa

    def index
        @companies = Company.all
    end

    def show

    end

    def new
      @company = Company.new
    end

    def create
      @company = Company.new(company_params)
      if @company.save 
        redirect_to new_recruiter_registration_path
      else
        render 'new'
      end
    end

    def edit 

    end
    
    def update
      if @company.update(company_params)
       redirect_to @company
      else
        render 'edit'
      end
    end

    private 
    
    def load_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :address, :cnpj, :domain, :website, :logo, :about)
    end
end 