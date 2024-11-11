class CoachesController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @user = User.coach.new
  end

  def create
    @user = User.coach.new(coach_params.merge(role: "coach"))

    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Welcome, #{@user.name}! Your account has been created.", status: 200
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def coach_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
