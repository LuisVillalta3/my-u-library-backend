class UserMailer < ApplicationMailer
  # default from: Rails.application.credentials.smtp_config[:from]

  def user_created
    @user = params[:user]
    @pass = params[:pass]

    mail(to: @user.email, subject: 'Welcome to My U Librarian!')
  end
end
