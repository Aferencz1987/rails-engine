class Api::V1::RevenuesController < ApplicationController
  def top_merchants
    Merchant.top_revenue(params[:quantity])
  end
end
