class RegistrationsController < InertiaController
  skip_before_action :authenticate

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # session_record = @user.sessions.create!
      # cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

      send_email_verification
      # redirect_to root_path, notice: "Welcome! You have signed up successfully"
      redirect_to sign_in_path, notice: "账户激活邮件已发送，请检查邮箱"
    else
      redirect_to sign_up_path, inertia: { errors: @user.errors.to_hash(true) }
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end

    def send_email_verification
      UserMailer.with(user: @user).email_verification.deliver_later
    end
end
