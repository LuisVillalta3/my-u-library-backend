class Api::V1::RequestStatusesController < ApplicationController
  def index
    render json: RequestStatus.all
  end
end
