class RegistrationsController < InertiaController
  skip_before_action :authenticate
  rate_limit to: 5, within: 5.minutes, only: :create, with: -> {
    redirect_back_or_to sign_up_path, alert: "Too many requests. Please try again later."
  }

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      send_email_verification
      render inertia: "registrations/check_email_guide", props: {
        resend_email: user_params[:email]
      }
    else
      existing_user = User.find_by(email: user_params[:email], verified: false)
      if existing_user
        UserMailer.with(user: existing_user).email_verification.deliver_later
        redirect_to sign_up_path, inertia: {
          errors: { email: [
            "An account with this email exists but hasn't been verified. We've sent a new verification email with magic link to #{user_params[:email]}. Check your inbox." ] }
        }
      else
        redirect_to sign_up_path, inertia: { errors: @user.errors.to_hash(true) }
      end
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :terms_of_service)
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
