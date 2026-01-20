module Admin
  class AuthController < Admin::ApplicationController
    skip_before_action :authenticate_admin, only: %i[new create]

    def new
      redirect_to admin_root_path if current_admin
    end

    def create
      user = User.authenticate_by(email: params[:email], password: params[:password])
      return redirect_to admin_sign_in_path, alert: "登录失败，密码或邮箱错误" unless user
      return redirect_to admin_sign_in_path, alert: "请先验证邮箱" unless user.verified?
      return redirect_to admin_sign_in_path, alert: "您没有管理员权限" unless user.admin?

      session[:admin_user_id] = user.id
      redirect_to admin_root_path, notice: "欢迎来到管理后台"
    end

    def destroy
      session.delete(:admin_user_id)
      redirect_to admin_sign_in_path, notice: "已退出管理后台"
    end
  end
end
