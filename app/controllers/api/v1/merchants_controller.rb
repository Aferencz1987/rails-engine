class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:per_page]
      if (params[:page]).to_i > 1
        offset = params[:per_page].to_i * (params[:page].to_i - 1)
      else
        offset = 0
      end
      merchants_custom_page_limit = Merchant.all.limit(params[:per_page]).offset(offset)

      render json: merchants_custom_page_limit
    else
      if (params[:page]).to_i > 1
        offset = 20 * (params[:page].to_i - 1)
      else
        offset = 0
      end
      merchants_default_page_limit = Merchant.all.limit(20).offset(offset)
      render json: merchants_default_page_limit
    end
  end

  def show
    render json: Merchant.find(params[:id])
  end

  def find
    found = Merchant.where('name ILIKE ?', "%#{params[:name]}%")
  #   find by a portion of the name. use active record to find any piece
    render json: found
  end
end
