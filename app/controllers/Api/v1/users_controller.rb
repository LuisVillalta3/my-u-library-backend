class Api::V1::UsersController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, :user_not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_json_error :bad_request, :missing_user_params
  end

  def index
    page = params[:page] || 1
    limit = params[:rowsPerPage] || 10
    offset = (page.to_i - 1) * limit.to_i
    @users = User.offset(offset).limit(limit)
    @users = @users.where('first_name ILIKE ?', "%#{params[:first_name]}%") if params[:first_name].present?
    @users = @users.where('last_name ILIKE ?', "%#{params[:last_name]}%") if params[:last_name].present?
    @users = @users.where('email ILIKE ?', "%#{params[:email]}%") if params[:email].present?
    render json: {
      rows: @users.as_json(include: :role),
      total: User.count,
    }
  end

  def show
    render json: User.find(params[:id]), include: :role
  end

  def create
    @user = User.new(user_params)
    # @pass = generate_password
    # @user.password = @pass
    # @user.password_confirmation = @pass

    return render_json_error :unprocessable_entity, :user_fields_errors, { errors: @user.errors } if !@user.save
    # UserMailer.with(user: @user, pass: @pass).user_created.deliver_now
    render json: @user, status: :created
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role_id, :password, :password_confirmation)
  end

  def generate_password
    (0...16).map { (65 + rand(26)).chr }.join
  end
end
