class JobsController < ApplicationController
    def index
        @jobs = Job.all
    end

    def show
        @job = Job.find(params[:id])
    end

    def new
        @job = Job.new
    end

    def create
        @job = Job.new(job_params)
        @job.company = current_recruiter.company

        if @job.save
            flash[:notice] = 'Vaga publicada com sucesso'
            redirect_to @job
        else
            render :new
        end
    end

    def edit 
        @job = Job.find(params[:id])
      end
    
      def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
          flash[:notice] = 'Vaga editada com sucesso'
          redirect_to @job
        else
          render 'edit'
        end
    end

    private

    def job_params
        params.require(:job).permit(:title, :description, :remuneration, 
                                    :level, :requirements, :expiration_date, 
                                    :spots_available)
    end
end