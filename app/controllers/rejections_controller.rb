class RejectionsController < ApplicationController
    def show

    end

    def new
      @application = Application.find(params[:application_id])
      @rejection = Rejection.new
    end

    def create
      @application = Application.find(params[:application_id])
      @job = @application.job
      @rejection = Rejection.new(rejection_params)
      @rejection.application = @application

      if @rejection.save
        flash[:notice] = 'Candidatura rejeitada'
        @application.rejected!
        redirect_to job_applications_path(@job)
      else
        render :new
      end
    end

    private

    def rejection_params
      params.require(:rejection).permit(:motive)
    end
end