# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
      return redirect_to admin_sign_in_path unless perform_admin_authentication
    end

    def perform_admin_authentication
      user_id = session[:admin_user_id]
      return false unless user_id

      @current_admin = User.find_by(id: user_id)
      @current_admin&.admin? ? true : false
    end

    def current_admin
      @current_admin
    end

    helper_method :current_admin

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end