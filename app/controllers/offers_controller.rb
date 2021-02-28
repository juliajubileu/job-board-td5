class OffersController < ApplicationController
  before_action :authenticate_candidate!, only: [:show, :accept]
  before_action :authenticate_recruiter!, only: [:new, :create]

    def show
      @offer = Offer.find(params[:id])
      @application = @offer.application
      @job = @application.job
      @company = @job.company
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
        @offer.pending!
        redirect_to job_applications_path(@job)
      else
        render :new
      end
    end

    def accept
      @offer = Offer.find(params[:id])
      @offer.accepted!
      redirect_to candidates_path
    end

    private

    def offer_params
      params.require(:offer).permit(:message, :salary, :starting_date)
    end
end