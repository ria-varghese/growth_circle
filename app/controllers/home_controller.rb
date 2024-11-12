class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if current_user
      @employee = Employee.find(current_user.id) if current_user.employee?
      @coach = Coach.find(current_user.id) if current_user.coach?
    end
  end
end
