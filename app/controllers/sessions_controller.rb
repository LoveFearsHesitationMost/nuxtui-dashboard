class SessionsController < InertiaController
  skip_before_action :authenticate, only: %i[ new create ]
  before_action :require_no_authentication, only: :new
  before_action :set_session, only: :destroy
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> {
    redirect_back_or_to sign_in_path, alert: "Too many requests. Please try again later."
  }

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new
  end

  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    return redirect_to sign_in_path, alert: "Your credential is invalid, check and try again" unless user
    return redirect_to sign_in_path, alert: "Your account has not verified yet. Check your email inbox." unless user.verified?

    @session = user.sessions.create!
    cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

    redirect_to root_path
  end

  def destroy
    @session.destroy
    if Current.session.id == params[:id]
      redirect_to sessions_path, notice: "That session has been logged out"
    else
      redirect_to root_path, notice: "You are signed out."
    end
  end

  private

  def set_session
    @session = Current.user.sessions.find(params[:id])
  end
end
