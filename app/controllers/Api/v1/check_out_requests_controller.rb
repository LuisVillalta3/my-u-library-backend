class Api::V1::CheckOutRequestsController < ApiController
  def index
    render json: CheckOutRequest.all
  end
end
