class CompanyProgramsController < ApplicationController
  layout :company_landing_page

  before_action :find_company
  before_action :find_program, only: [ :show, :unenroll ]
  before_action :set_employee
  after_action :verify_authorized

  def index
    authorize @company, :show_company_page?
    @breadcrumbs = [
      { name: "Programs", path: company_programs_path(@company.slug) }
    ]
    render
  end

  def show
    authorize @company, :show_company_page?
    @breadcrumbs = [
      { name: "Programs", path: company_programs_path(@company.slug) },
      { name: @program.name, path: company_program_path(@company.slug, @program) }
    ]
    @coaches = @program.coaches
  end

  def unenroll
    authorize @company, :show_company_page?
    if @employee.enrolled_in?(@program)
      @employee.unenroll
      flash[:notice] = "You have successfully unenrolled from #{@program.name}."
    else
      flash[:alert] = "You are not enrolled in this program."
    end

    redirect_to company_programs_path(@company.slug)
  end

  private

  def find_company
    @company ||= Company.find_by!(slug: params[:company_slug])
  end

  def find_program
    @program ||= @company.coaching_programs.find(params[:id])
  end

  def company_landing_page
    "turbo_rails/frame" if turbo_frame_request?
    "company_landing"
  end

  def set_employee
    @employee ||= Employee.find(current_user.id)
  end
end
