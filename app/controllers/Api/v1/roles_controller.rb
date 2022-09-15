class Api::V1::RolesController < ApiController
  def index
    render json: Role.all
  end
end
