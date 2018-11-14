class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show, :update, :destroy]

  # GET /promotions
  def index
    @promotions = Promotion.all
    json_response(@promotions)
  end

  # POST /promotions
  def create
    @promotion = Promotion.create!(promotion_params)
    json_response(@promotion, :created)
  end

  # GET /promotions/:id
  def show
    json_response(@promotion)
  end

  # PUT /promotions/:id
  def update
    @promotion.update(promotion_params)
    head :no_content
  end

  # DELETE /promotions/:id
  def destroy
    @promotion.destroy
    head :no_content
  end

  private

  def promotion_params
    # whitelist params
    params.permit(:code, :percent, :start_date, :end_date)
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
