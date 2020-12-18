class Api::V1::Merchants::FindController < ApplicationController

  def index
    if params[:name]
      merchant = Merchant.search(params[:name])
    elsif params[:created_at]
      merchant = Merchant.create_search(params[:created_at])
    else
      merchant = Merchant.update_search(params[:updated_at])
    end
    render json: MerchantSerializer.new(merchant)
  end

  def show
    if params[:name]
      merchant = Merchant.search(params[:name])
    elsif params[:created_at]
      merchant = Merchant.create_search(params[:created_at])
    else
      merchant = Merchant.update_search(params[:updated_at])
    end
    render json: MerchantSerializer.new(merchant.first)
  end
end
