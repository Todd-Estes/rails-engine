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
    render json: ItemSerializer.new(Item.create(item_params))
    # render json: ItemSerializer.new(Item.create(name: params[:name], description: params[:description], unit_price: params[:unit_price], merchant_id: params[:merchant_id]))
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    # item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price], merchant_id: params[:merchant_id])
    update = render json: ItemSerializer.new(item)
    # render json: ItemSerializer.new(item)
    # render json: Item.update(params[:id], item_params)
  end

  def destroy
    # render json: Item.delete(params[:id])
    Item.delete(params[:id])
  end

  private

  def item_params
    # params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :updated_at, :created_at)
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

end
