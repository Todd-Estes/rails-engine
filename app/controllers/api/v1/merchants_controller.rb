class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)

    # merchant.update(merchant_params)
    # merchant.update(name: params[:name])
    render json: MerchantSerializer.new(merchant)
  end

  def destroy
    Item.delete(Item.find_by(merchant_id: params[:id]))
    Merchant.delete(params[:id])
    # head :no_content
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
