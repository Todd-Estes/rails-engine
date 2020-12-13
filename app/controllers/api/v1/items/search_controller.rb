class API::V1::Merchants::SearchController < ApplicationController

  def show
    render json: Item.find(params[:id])
  end
end
