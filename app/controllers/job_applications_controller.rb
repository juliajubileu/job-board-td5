class JobApplicationsController < ApplicationController
  before_action :set_job, only: [:index, :new, :create]
  before_action :authenticate_candidate!, except: [:index]
  before_action :authenticate_recruiter!, only: [:index]

  def index

  end

  def show
    @job_application = current_candidate.job_applications.find(params[:id])
    @job = @job_application.job
  end

  def new
    @job_application = JobApplication.new
  end

  def create
    @candidate = Candidate.find(current_candidate.id)
    @job_application = JobApplication.new(job: @job, candidate: @candidate)

    if @job_application.save
      flash[:notice] = 'Candidatura realizada com sucesso'
      @job_application.pending!
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def destroy
    @job_application = JobApplication.find(params[:id])
    @job_application.destroy

    flash[:notice] = 'Você não está mais concorrendo a esta vaga!'
    redirect_to candidates_path
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end
end