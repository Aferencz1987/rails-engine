module OffsetByPageable
  def create_offset
    if params[:per_page]
      if (params[:page]).to_i > 1
        offset = params[:per_page].to_i * (params[:page].to_i - 1)
      else
        offset = 0
      end
    else
      if (params[:page]).to_i > 1
        offset = 20 * (params[:page].to_i - 1)
      else
        offset = 0
      end
    end
  end
end
