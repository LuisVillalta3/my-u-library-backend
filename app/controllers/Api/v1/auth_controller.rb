require 'bcrypt'

class Api::V1::AuthController < ApiController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:email])
    if @user && compare_passwords(@user.encrypted_password, params[:password])
      token = JsonWebToken.encode(user: @user.to_json(include: :role))
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def compare_passwords(user_password, password_param)
    BCrypt::Password.new(user_password) == password_param
  end
end
