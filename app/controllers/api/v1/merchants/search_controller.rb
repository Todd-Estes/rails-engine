class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: Item.where(merchant_id: params[:id])
  end
end
