class Api::V1::RevenuesController < ApplicationController
  def top_merchants
    render json: Merchant.top_revenue(params[:quantity]), each_serializer: RevenueSerializer if params[:quantity]
    render json: {message: 'You lost boo boo',
            error: ['No merchant quantity provided. Please provide merchant quantity.']},
            status: :bad_request unless params[:quantity]
  end

  def total_revenue_by_date
    if params[:start_date] && params[:end_date]

    else
      render json: {message: 'You lost boo boo',
              error: ['No start or end date provided. Please provide start or end date.']},
              status: :bad_request
  end
end
