class OffersController < ApplicationController
  before_action :authenticate_recruiter!, except: %i[show]

    def show

    end

    def new
      @application = Application.find(params[:application_id])
      @offer = Offer.new
    end

    def create
      @application = Application.find(params[:application_id])
      @job = @application.job
      @offer = Offer.new(offer_params)
      @offer.application = @application

      if @offer.save
        flash[:notice] = 'Oferta enviada'
        @application.approved!
        redirect_to job_applications_path(@job)
      else
        render :new
      end
    end

    private

    def offer_params
      params.require(:offer).permit(:message, :salary, :starting_date)
    end
end