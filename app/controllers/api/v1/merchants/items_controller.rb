class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.items
  end

  def show; end
end
