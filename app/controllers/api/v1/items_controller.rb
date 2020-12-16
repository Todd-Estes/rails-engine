class Api::V1::ItemsController < ApplicationController

  def index
    # render json: Item.all
    render json: ItemSerializer.new(Item.all)
  end

  def show
    # item = Item.find(params[:id])
    # render json: ItemSerializer(Item.find(params[:id]))
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item =  Item.create(item_params)
    render json: ItemSerializer.new(item)
  end

  def update
    render json: Item.update(params[:id], item_params)
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end
