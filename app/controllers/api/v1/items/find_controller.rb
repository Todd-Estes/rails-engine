class Api::V1::Items::FindController < ApplicationController

  def index
    if params[:created_at]
      item = Item.create_search(params[:created_at])
    elsif params[:updated_at]
      item = Item.update_search(params[:updated_at])
    elsif params[:unit_price]
      item = Item.price_search(params[:unit_price].to_f)
    elsif params[:merchant_id]
      item = Item.merchant_search(params[:merchant_id].to_i)
    else
      attribute = params.keys[0]
      query = params[attribute]
      item = Item.search(attribute, query)
    end
    render json: ItemSerializer.new(item)
  end

  def show
    if params[:created_at]
      item = Item.create_search(params[:created_at])
    elsif params[:updated_at]
      item = Item.update_search(params[:updated_at])
    elsif params[:unit_price]
      item = Item.price_search(params[:unit_price].to_f)
    elsif params[:merchant_id]
      item = Item.merchant_search(params[:merchant_id].to_i)
    else
      attribute = params.keys[0]
      query = params[attribute]
      item = Item.search(attribute, query)
    end
    render json: ItemSerializer.new(item.first)
  end
end
