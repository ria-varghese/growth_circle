class EmployeesController < ApplicationController
  include Wicked::Wizard

  skip_before_action :authenticate_user!
  steps :select_company, :select_program

  def show
    @employee = Employee.new
    case step
    when :select_program
      user = Employee.find(session[:employee_id])
      @programs = get_company(user.email).coaching_programs
    end

    render_wizard @employee
  end

  def update
    @employee = Employee.new
    case step
    when :select_company
      @employee.attributes = employee_params.merge(company: get_company(employee_params[:email]))
      if @employee.save
        session[:employee_id] = @employee.id
      end
    when :select_program
      @employee.assign_attributes(employee_params)
    end

    render_wizard @employee
  end

  private

  def employee_params
    params.require(:employee).permit(:email, :name, :password, :password_confirmation)
  end

  def finish_wizard_path
    root_path
  end

  def get_company(email)
    Company.find_by(domain: email.split("@").last)
  end
end
