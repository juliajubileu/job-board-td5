class RecruitersController < ApplicationController
  def index
    @company = current_recruiter.company
  end
end
