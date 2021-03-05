class RejectionsController < ApplicationController
  before_action :authenticate_recruiter!, :set_job_application

    def new
      @rejection = Rejection.new
    end

    def create
      @rejection = Rejection.new(rejection_params)
      @rejection.job_application = @job_application
      @job = @job_application.job

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

    def set_job_application
      @job_application = JobApplication.find(params[:job_application_id])
    end
end