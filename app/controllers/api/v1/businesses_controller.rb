class Api::V1::BusinessesController < Api::V1::ApiController

  def show
    yu = Yelp::Utils.new(params[:id])
    biz = yu.get_business
    render json: {business: biz}, status: yu.status
  end

end
