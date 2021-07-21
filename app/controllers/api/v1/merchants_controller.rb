require './app/controllers/concerns/offset_by_pageable'

class Api::V1::MerchantsController < ApplicationController
  include OffsetByPageable
  def index
    merchants = Merchant.all.limit(params[:per_page]).offset(create_offset) if params[:per_page]
    merchants = Merchant.all.limit(20).offset(create_offset) unless params[:per_page]
    render json: merchants
  end

  def show
    render json: Merchant.find(params[:id])
  end

  def find
    render json: Merchant.find_by('name ILIKE ?', "%#{params[:name]}%") if params[:name]
    render status: :not_found unless params[:name]
  end

  def find_all
    render json: Merchant.where('name ILIKE ?', "%#{params[:name]}%") if params[:name]
    render status: :not_found unless params[:name]
  end
end
# http://localhost:3000/api/v1/revenue/merchants?quantity=10
