class Api::V1::UsersController < ApiController
  def index
    page = params[:page] || 1
    limit = params[:rowsPerPage] || 10
    offset = (page.to_i - 1) * limit.to_i
    @users = User.offset(offset).limit(limit)
    @users = @users.where('first_name ILIKE ?', "%#{params[:name]}%") if params[:name].present?
    render json: {
      rows: @users,
      total: User.count,
    }
  end
end
