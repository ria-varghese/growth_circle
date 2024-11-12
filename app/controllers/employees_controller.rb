class EmployeesController < ApplicationController
  include Wicked::Wizard

  skip_before_action :authenticate_user!
  before_action :find_employee, only: [ :show, :update ]
  before_action :find_company, only: [ :show, :update ]
  steps :select_program, :select_coach
  layout "company_landing", only: [ :show, :update ]

  def new
    @employee = Employee.new
  end
  def create
    @employee = Employee.new(employee_params.merge(company: get_company(employee_params[:email])))
    if @employee.save
      session[:employee_id] = @employee.id
      redirect_to employee_path(steps.first)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    case step
    when :select_program
      @programs = get_company(@employee.email).coaching_programs
    when :select_coach
      program = CoachingProgram.find(session[:program_id])
      @coaches = program.coaches
    end

    render_wizard
  end

  def update
    case step
    when :select_program
      @employee.assign_attributes(coaching_program_params)
      if @employee.save
        session[:program_id] = coaching_program_params[:coaching_program_id]
      end
    when :select_coach
      @employee.assign_attributes(coach_and_detail_params)
    end

    render_wizard @employee
  end

  private

  def employee_params
    params.require(:employee).permit(:email, :name, :password, :password_confirmation)
  end

  def coaching_program_params
    params.require(:employee).permit(:coaching_program_id, :coaching_requirements)
  end

  def coach_and_detail_params
    params.require(:employee).permit(:coach_id, :phone_number, :gender, :nickname)
  end

  def finish_wizard_path
    sign_in(@employee)
    flash[:notice]= "Welcome to GrowthCircle #{@employee.name}"
    root_path
  end

  def get_company(email)
    Company.find_by(domain: email.split("@").last)
  end

  def find_company
    @company ||= @employee.company
  end

  def find_employee
    @employee ||= Employee.find(session[:employee_id])
  end
end
