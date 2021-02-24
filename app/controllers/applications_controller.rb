class ApplicationsController < ApplicationController
  before_action :authenticate_candidate!, except: %i[index]

  def index
    @job = Job.find(params[:job_id])
  end

  def show
    @application = current_candidate.applications.find(params[:id])
    @job = @application.job
  end

  def new
    @job = Job.find(params[:job_id])
    @application = Application.new
  end

  def create
    @job = Job.find(params[:job_id])
    @application = Application.new
    @candidate = Candidate.find(current_candidate.id)

    @application.job = @job
    @application.candidate = @candidate

    if @application.save
      flash[:notice] = 'Candidatura realizada com sucesso'
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    flash[:notice] = 'Você não está mais concorrendo a esta vaga!'
    redirect_to candidates_path
  end
end
