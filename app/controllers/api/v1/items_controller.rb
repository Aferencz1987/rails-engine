class Api::V1::ItemsController < ApplicationController
  include OffsetByPageable
  def index
    items = Item.all.limit(params[:per_page]).offset(create_offset) if params[:per_page]
    items = Item.all.limit(20).offset(create_offset) unless params[:per_page]
    render json: items
  end

  def show
    render json: Item.find(params[:id])
  end

  def find
    render json: Item.find_by('name ILIKE ?', "%#{params[:name]}%") if params[:name]
    render status: :not_found unless params[:name]
  end

  def find_all
    render json: Item.where('name ILIKE ?', "%#{params[:name]}%") if params[:name]
    render status: :not_found unless params[:name]
  end
end
