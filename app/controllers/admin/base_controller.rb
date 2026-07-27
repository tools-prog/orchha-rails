module Admin
  class BaseController < ApplicationController
    before_action :require_authentication
    layout "admin"

    helper_method :current_user

    private

    def current_user
      Current.session&.user
    end

    def require_admin
      return if current_user&.admin?

      redirect_to admin_root_path, alert: "Only admins can do that."
    end
  end
end
