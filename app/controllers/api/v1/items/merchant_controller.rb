class Api::V1::Items::MerchantController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    render json: item.merchant
  end

  def show; end
end
