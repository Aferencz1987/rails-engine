class Api::V1::MerchantsController < ApplicationController
  def index
    #if params[:per_page]
    render json: Merchant.all
    #default to 20 objects per page but can be changed
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
