class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    top_merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(top_merchants)
  end

end
