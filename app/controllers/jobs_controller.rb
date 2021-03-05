class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :disable, :enable]
  before_action :authenticate_recruiter!, except: [:index, :show]

  def index
    @jobs = Job.all
  end

  def show

  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.company = current_recruiter.company

    if @job.save
      flash[:notice] = 'Vaga publicada com sucesso'
      @job.enabled!
      redirect_to @job
    else
      render :new
    end
  end

  def edit 

  end
    
  def update
    if @job.update(job_params)
      flash[:notice] = 'Vaga editada com sucesso'
      redirect_to @job
    else
      render 'edit'
    end
  end

  def disable
    @job.disabled!
    redirect_to @job
  end

  def enable
    @job.enabled!
    redirect_to @job
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :remuneration, 
                                :level, :requirements, :expiration_date, 
                                :spots_available)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end