class Api::V1::ItemsController < ApplicationController
  include OffsetByPageable
  def index
    if params[:per_page]
      items = Item.all.limit(params[:per_page]).offset(create_offset)
    else
      items = Item.all.limit(20).offset(create_offset)
    end
    render json: items
  end

  def show
    render json: Item.find(params[:id])
  end

  def find
    if params[:name]
      found = Item.find_by('name ILIKE ?', "%#{params[:name]}%")
      render json: found
    else
      render status: :not_found
    end
  end

  def find_all
    if params[:name]
      found = Item.where('name ILIKE ?', "%#{params[:name]}%")
      render json: found
    else
      render status: :not_found
    end
  end
end
