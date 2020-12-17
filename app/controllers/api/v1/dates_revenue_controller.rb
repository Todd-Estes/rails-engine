class Api::V1::DatesRevenueController < ApplicationController

  def show
    render json: RevenueSerializer.new(Invoice.revenue_dates(params[:start], params[:end]))
  end
end
