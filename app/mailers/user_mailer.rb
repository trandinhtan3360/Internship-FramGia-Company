class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

  def welcome(user_email)
   @user=User.find_by_email user_email
   Rails.logger.info "==========sending welcome email to ==> #{@user.email}"
   mail(:to => @user.email, :subject => "Hi #{@user.username},Welcome to #{configatron.app_name}")
end
end
