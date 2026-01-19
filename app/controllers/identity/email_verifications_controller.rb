class Identity::EmailVerificationsController < InertiaController
  skip_before_action :authenticate, only: :show

  before_action :set_user, only: :show

  def show
    @user.update! verified: true
    redirect_to root_path, notice: "激活成功，现在您可以登录了"
  end

  def create
    send_email_verification
    redirect_to root_path, notice: "我们已发送一封激活邮件到您的邮箱，请激活后登录"
  end

  private
    def set_user
      @user = User.find_by_token_for!(:email_verification, params[:sid])
    rescue StandardError
      redirect_to edit_identity_email_path, alert: "激活链接无效或已过期"
    end

    def send_email_verification
      UserMailer.with(user: Current.user).email_verification.deliver_later
    end
end
