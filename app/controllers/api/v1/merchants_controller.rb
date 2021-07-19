class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:per_page]
      if (params[:page]).to_i > 1
        offset = params[:per_page].to_i * (params[:page].to_i - 1)
      else
        offset = 0
      end
      merchants_custom_page_limit = Merchant.all.limit(params[:per_page]).offset(offset)

      render json: { data: merchants_custom_page_limit }
    else
      if (params[:page]).to_i > 1
        offset = 20 * (params[:page].to_i - 1)
      else
        offset = 0
      end
      merchants_default_page_limit = Merchant.all.limit(20).offset(offset)

      render json: { data: merchants_default_page_limit }
    end
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
