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

  def create
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.items.create(item_params), status: :created
  end

  def destroy
    Item.find(params[:id]).destroy if params[:id]
    render status: :not_found unless params[:id]
  end

  def update
    item = Item.find(params[:id])
     if item.update(item_params)
       render json: item
     else
       render status: :not_found
     end
  end

  def find
    render json: Item.find_by('name ILIKE ?', "%#{params[:name]}%") if params[:name]
    render status: :not_found unless params[:name]
  end

  def find_all
    render json: Item.where('name ILIKE ?', "%#{params[:name]}%") if params[:name]
    render status: :not_found unless params[:name]
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
