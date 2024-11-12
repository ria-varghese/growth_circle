class EmployeesController < ApplicationController
  include Wicked::Wizard

  skip_before_action :authenticate_user!
  steps :select_program, :select_coach

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params.merge(company: company))
    if @employee.save
      sign_in(@employee)
      redirect_to employee_path(steps.first)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @employee = Employee.find(current_user.id)
    @programs = @employee.company.coaching_programs
    case step
    when :select_coach
      program = CoachingProgram.find(session[:program_id])
      @coaches = program&.coaches
    end

    render_wizard
  end

  def update
    @employee = Employee.find(current_user.id)
    case step
    when :select_program
      @employee.assign_attributes(program_params)
      session[:program_id] = program_params[:coaching_program_id]
    when :select_coach
      @employee.assign_attributes(coach_and_detail_params)
    end

    render_wizard @employee
  end

  private

  def finish_wizard_path
    flash[:notice]= "You've been successfully enrolled"
    root_path
  end

  def company
    @company ||= Company.find_by(domain: employee_params[:email].split("@").last)
  end

  def program_params
    params.require(:employee).permit(:coaching_program_id, :coaching_requirements)
  end

  def coach_and_detail_params
    params.require(:employee).permit(:coach_id, :phone_number, :gender, :nickname)
  end

  def employee_params
    params.require(:employee).permit(:email, :name, :password, :password_confirmation)
  end
end
