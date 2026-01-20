module Admin
  class DashboardController < Admin::ApplicationController
    def dashboard
      @users_count = User.count
      @admin_users_count = User.where(admin: true).count
      @regular_users_count = User.where(admin: false).count
      @sessions_count = Session.count
    end
  end
end
