class ApplicationController < ActionController::Base
  include ApiResponders
  include ApiExceptions
  include Pundit::Authorization
  include Redirections
  protect_from_forgery

  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
