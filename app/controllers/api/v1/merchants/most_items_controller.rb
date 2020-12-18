class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    merchant = Merchant.most_items(params[:quantity])
    require "pry"; binding.pry
    merch = render json: MerchantSerializer.new(merchant)
    require "pry"; binding.pry
  end
end
