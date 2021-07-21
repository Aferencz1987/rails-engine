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
    if params[:name]
      found = Merchant.find_by('name ILIKE ?', "%#{params[:name]}%")
      render json: found
    else
      render status: :not_found
    end
  end

  def find_all
    if params[:name]
      found = Merchant.where('name ILIKE ?', "%#{params[:name]}%")
      render json: found
    else
      render status: :not_found
    end
  end
end
