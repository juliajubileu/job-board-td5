class CompaniesController < ApplicationController
    def show
        @company = Company.all
    end

    def index
        @company = Company.find(params[:id])
    end

    # Relacionar com primeiro recrutador
    def new
        @company = Company.new
    end

    def create
        @company = Company.new
        if @company.save 
            redirect to @company
        else
            render 'new'
        end
    end

    private 
    
    def company_params
        param.require(:company).permit(:name, :address, :cnpj, :domain, :website)
    end
end 