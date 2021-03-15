class DenialsController < ApplicationController
  before_action :authenticate_candidate!, except: [:show]
  before_action :authenticate_recruiter!, only: [:show]
  def show
    @denial = Denial.find(params[:id])
    @offer = @denial.offer
  end

  def new
    @offer = Offer.find(params[:offer_id])
    @denial = Denial.new
  end

  def create
    @offer = Offer.find(params[:offer_id])
    @denial = Denial.new(denial_params)
    @denial.offer = @offer

    if @denial.save
      flash[:notice] = 'Oferta recusada'
      @offer.denied!
      redirect_to candidates_path
    else
      render :new
    end
  end

  private

  def denial_params
    params.require(:denial).permit(:motive)
  end
end
