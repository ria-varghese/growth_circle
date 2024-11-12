class CoachesController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @coach = Coach.new
  end

  def create
    @coach = Coach.new(coach_params)

    if @coach.save
      sign_in(@coach)
      redirect_to root_pathN
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @coach = Coach.find(params[:id])
    @q = @coach.enrollments.ransack(params[:q])
    @enrollments = @q.result(distinct: true)
    @companies = @coach.enrollments.includes(:company).map(&:company).uniq
  end

  private

  def coach_params
    params.require(:coach).permit(:name, :email, :password, :password_confirmation)
  end
end
