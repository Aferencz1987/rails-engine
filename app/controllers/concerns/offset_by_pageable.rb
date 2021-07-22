module OffsetByPageable
  def create_offset
    offset = params[:per_page].to_i * (params[:page].to_i - 1) if params[:page].to_i > 1 if params[:per_page]
    offset = 20 * (params[:page].to_i - 1) if params[:page].to_i > 1
  end
end
