class CandidatesController < ApplicationController
  before_action :authenticate_candidate!

  def index
    @job_applications = current_candidate.job_applications
  end
end
