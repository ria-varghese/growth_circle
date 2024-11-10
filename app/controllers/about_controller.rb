class AboutController < ApplicationController
  skip_before_action :authenticate_user!

  layout "home"
  def index
  end
end
