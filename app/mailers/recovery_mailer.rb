class RecoveryMailer < ApplicationMailer
  default from: "passwords@mark423.com"
  layout "mailer"
  def password_reset(user, recovery)
    @user = user
    @recovery = recovery
    mail to: user.email, subject: "Password reset"
  end
end
