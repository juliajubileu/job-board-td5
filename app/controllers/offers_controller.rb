class OffersController < ApplicationController
  before_action :set_offer, :authenticate_candidate!, only: %i[show accept]
  before_action :set_job_application, :authenticate_recruiter!, only: %i[new
                                                                         create]
  def show
    @job_application = @offer.job_application
    define_job_attribute
    @company = @job.company
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    define_job_attribute
    @offer.job_application = @job_application
    if @offer.save
      @job_application.approved!
      @offer.pending!
      redirect_to job_job_applications_path(@job), notice: t('.success')
    else
      render :new
    end
  end

  def accept
    @offer.accepted!
    redirect_to candidates_path
  end

  private

  def offer_params
    params.require(:offer).permit(:message, :salary, :starting_date)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def set_job_application
    @job_application = JobApplication.find(params[:job_application_id])
  end

  def define_job_attribute
    @job = @job_application.job
  end
end
