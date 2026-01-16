class SessionsController < InertiaController
  skip_before_action :authenticate, only: %i[ new create ]

  before_action :set_session, only: %i[ destroy ]

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new
  end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      @session = user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

      redirect_back_or_to root_path, notice: "登录成功，欢迎回来"
    else
      redirect_to sign_in_path, alert: "登录失败，密码或邮箱错误"
    end
  end

  def destroy
    @session.destroy
    redirect_to(sessions_path, notice: "该会话已注销")
  end

  private
    def set_session
      @session = Current.user.sessions.find(params[:id])
    end
end
