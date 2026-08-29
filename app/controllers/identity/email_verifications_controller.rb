class Identity::EmailVerificationsController < InertiaController
  skip_before_action :authenticate, only: %i[ show new create ]

  before_action :set_user, only: :show

  def show
    @user.update! verified: true
    redirect_to root_path, notice: "Thank you for verifying your email address! You are able to sign in now."
  end

  def new
  end

  def create
    user = User.find_by(email: params[:email], verified: false)
    if user
      UserMailer.with(user: user).email_verification.deliver_later
    end
    redirect_back_or_to sign_in_path, notice: "If an unverified account exists with that email, we've sent a verification link."
  end

  private
  def set_user
    @user = User.find_by_token_for!(:email_verification, params[:sid])
  rescue StandardError
    redirect_to edit_identity_email_path, alert: "That email verification link is invalid"
  end

  def send_email_verification
    UserMailer.with(user: Current.user).email_verification.deliver_later
  end
end
