class CoachesController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @coach = Coach.new
  end

  def create
    @coach = Coach.new(coach_params)

    if @coach.save
      sign_in(@coach)
      redirect_to root_path, notice: "Welcome, #{@coach.name}! Your account has been created.", status: 200
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def coach_params
    params.require(:coach).permit(:name, :email, :password, :password_confirmation)
  end
end
