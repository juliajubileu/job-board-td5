class HomeController < ApplicationController
  def index
  end

  def search
    query = params[:q]
    @companies = Company.where('name ilike ?', "%#{query}%")
    @jobs = Job.where('title ilike ? OR level ilike ?', "%#{query}%",
                      "%#{query}%")
  end
end
