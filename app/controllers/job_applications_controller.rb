class JobApplicationsController < ApplicationController
  before_action :authenticate_candidate!, except: %i[index]
  before_action :authenticate_recruiter!, only: %i[index]

  def index
    @job = Job.find(params[:job_id])
  end

  def show
    @job_application = current_candidate.job_applications.find(params[:id])
    @job = @job_application.job
  end

  def new
    @job = Job.find(params[:job_id])
    @job_application = JobApplication.new
  end

  def create
    @job = Job.find(params[:job_id])
    @job_application = JobApplication.new
    @candidate = Candidate.find(current_candidate.id)

    @job_application.job = @job
    @job_application.candidate = @candidate

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
end