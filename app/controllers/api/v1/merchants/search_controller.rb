class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end

  def show
    require "pry"; binding.pry
    results = Merchant.revenue(params[:id])
    require "pry"; binding.pry
    rev = render json: RevenueSerializer.new(results)
    require "pry"; binding.pry
  end
end
