class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(name: params[:name]))
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:name])
    render json: MerchantSerializer.new(merchant)
  end

  def destroy
    Item.delete(Item.find_by(merchant_id: params[:id]))
    Merchant.delete(params[:id])
    # head :no_content
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
