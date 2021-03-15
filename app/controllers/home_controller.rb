class HomeController < ApplicationController
  def index
  end

  def search
    @companies = Company.where('name like ?', "%#{params[:q]}%")
    @jobs = Job.where('title like ? OR level like ?', "%#{params[:q]}%",
                      "%#{params[:q]}%")
  end
end
