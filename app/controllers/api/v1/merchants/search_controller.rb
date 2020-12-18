class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end

  def show
    render json: RevenueSerializer.new(Merchant.revenue(params[:id]))
  end
end
