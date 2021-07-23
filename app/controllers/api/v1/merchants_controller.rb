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

  def most_items
    if params[:quantity].to_i == 0 || params[:quantity].to_i.negative?
      render json: {message: 'You lost boo boo',
              error: ['Item number less than 1. Please provide quantity greater than 1.']},
              status: :bad_request
    elsif params[:quantity]
      render json: Merchant.most_items_sold(params[:quantity]), each_serializer: MostItemSerializer
    else
      render json: Merchant.most_items_sold(5), each_serializer: MostItemSerializer
    end
  end
end
