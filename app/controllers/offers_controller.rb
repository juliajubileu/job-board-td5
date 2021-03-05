class OffersController < ApplicationController
  before_action :authenticate_candidate!, only: [:show, :accept]
  before_action :authenticate_recruiter!, only: [:new, :create]

    def show
      @offer = Offer.find(params[:id])
      @job_application = @offer.job_application
      @job = @job_application.job
      @company = @job.company
    end

    def new
      @job_application = JobApplication.find(params[:job_application_id])
      @offer = Offer.new
    end

    def create
      @job_application = JobApplication.find(params[:job_application_id])
      @job = @job_application.job
      @offer = Offer.new(offer_params)
      @offer.job_application = @job_application

      if @offer.save
        flash[:notice] = 'Oferta enviada'
        @job_application.approved!
        @offer.pending!
        redirect_to job_job_applications_path(@job)
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