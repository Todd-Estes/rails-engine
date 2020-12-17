class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end

  def show
    results = Merchant.revenue(params[:id])
    render json: RevenueSerializer.new(results)
  end
end
