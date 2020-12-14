class Api::V1::Items::FindController < ApplicationController

  def show
    if params[:created_at]
      create_time = params[:created_at]
      item = create_search(create_time)
    elsif params[:updated_at]
      update_time = params[:updated_at]
      item = update_search(update_time)
    elsif params[:unit_price]
      price = params[:unit_price].to_f
      item = price_search(price)
    elsif params[:merchant_id]
      merchant_id = params[:merchant_id].to_i
      item = merchant_search(merchant_id)
    else
      attribute = params.keys[0]
      query = params[attribute]
      item = search(attribute, query)
    end
    render json: ItemSerializer.new(item)
  end

  private
  # refactor these into model methods
  def search(attribute, query)
    Item.where("#{attribute} ILIKE ?", "%#{query}%").first
  end

  def create_search(create_time)
    Item.where(created_at: create_time).first
  end

  def update_search(update_time)
    Item.where(updated_at: update_time).first
  end

  def price_search(price)
    Item.where(unit_price: price).first
  end

  def merchant_search(merchant_id)
    Item.where(merchant_id: merchant_id).first
  end
end
