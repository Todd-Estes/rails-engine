class Api::V1::Merchants::FindController < ApplicationController  

  def show
    if params[:name]
      merchant = search(params[:name])
    elsif params[:created_at]
      create_time = params[:created_at]
      merchant = create_search(create_time)
    else
      update_time = params[:updated_at]
      merchant = update_search(update_time)
    end
    render json: MerchantSerializer.new(merchant)
  end



  private
  # refactor these into merchant model methods; delete one of these name methods
  def search(name)
      Merchant.where("name ILIKE ?", "%#{params[:name]}%").first
  end

  def find_format(name)
    Merchant.where("lower(name) LIKE lower(?)", "%#{name}%").first
  end

  def create_search(create_time)
    Merchant.where(created_at: create_time).first
  end

  def update_search(update_time)
    Merchant.where(updated_at: update_time).first
  end
end
