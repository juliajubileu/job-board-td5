class CompaniesController < ApplicationController
    def index
        @company = Company.all
    end

    def show
        @company = Company.find(params[:id])
    end

    def new
        @company = Company.new
    end

    def create
        @company = Company.new(company_params)
        @company.recruiter = current_recruiter
        if @company.save 
            redirect_to @company
        else
            render 'new'
        end
    end

    private 
    
    def company_params
        params.require(:company).permit(:name, :address, :cnpj, :domain, :website, :logo)
    end
end 