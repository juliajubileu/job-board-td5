class CandidatesController < ApplicationController
    before_action :authenticate_candidate!
    
    def index
        @applications = current_candidate.applications
    end
end