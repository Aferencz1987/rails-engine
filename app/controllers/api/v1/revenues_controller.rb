class Api::V1::RevenuesController < ApplicationController
  def top_merchants(quantity_params)
    Merchant.top_revenue(quantity_params)
  end

end
