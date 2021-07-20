require './app/controllers/concerns/offset_by_pageable'

class Api::V1::MerchantsController < ApplicationController
  include OffsetByPageable
  def index
    if params[:per_page]
      merchants = Merchant.all.limit(params[:per_page]).offset(create_offset)
    else
      merchants = Merchant.all.limit(20).offset(create_offset)
    end
    render json: merchants
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
