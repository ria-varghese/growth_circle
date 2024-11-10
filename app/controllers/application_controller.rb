class ApplicationController < ActionController::Base
  include Pundit::Authorization
  protect_from_forgery

  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome back, #{current_user.name}!"
    if current_user.admin?
      rails_admin_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    flash[:alert] = "You have successfully signed out."
    root_path
  end

  def not_found
    render file: "public/404.html", status: :not_found, layout: false
  end
end
