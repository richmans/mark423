class RecoverController < AdminController
  skip_before_action :authenticated
  skip_before_action :privileged
  layout "clean"

  def create
    email = params.require(:email)
    user = User.find_by(email: email)
    if not user.nil?
      code = SecureRandom.alphanumeric(8)
      recovery = Recovery.create(user: user, valid_until: Time.now + 1.hour, code: code)
      RecoveryMailer.password_reset(user, recovery).deliver
      
    end
    redirect_to use_recovery_path
  end

  def reset
    code = params.require(:code)
    password = params.require(:password)
    password_confirmation = params.require(:password_confirmation)
    recovery = Recovery.find_by(code: code)
    if recovery.nil? || recovery.valid_until < Time.now || password != password_confirmation
      format.html { render :use, status: :unprocessable_entity }
      format.json { render json: [], status: :unprocessable_entity }
    end
    user = recovery.user
    user.password = password
    user.save
    recovery.delete
    flash[:info] = t(:password_reset_success)
    redirect_to login_path
  end
end
