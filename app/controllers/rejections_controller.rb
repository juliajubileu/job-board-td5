class RejectionsController < ApplicationController
    def index

    end

    def new
      @job_application = JobApplication.find(params[:job_application_id])
      @rejection = Rejection.new
    end

    def create
      @job_application = JobApplication.find(params[:job_application_id])
      @job = @job_application.job
      @rejection = Rejection.new(rejection_params)
      @rejection.job_application = @job_application

      if @rejection.save
        flash[:notice] = 'Candidatura rejeitada'
        @job_application.rejected!
        redirect_to job_job_applications_path(@job)
      else
        render :new
      end
    end

    private

    def rejection_params
      params.require(:rejection).permit(:motive)
    end
end