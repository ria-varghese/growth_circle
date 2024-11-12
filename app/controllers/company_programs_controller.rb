class CompanyProgramsController < ApplicationController
  # authorize_user only employees of this company can access this page
  layout "company_landing"

  before_action :find_company
  before_action :find_program, only: :show

  def index
    @breadcrumbs = [
      { name: "Programs", path: company_programs_path(@company.slug) }
    ]
    render
  end

  def show
    @breadcrumbs = [
      { name: "Programs", path: company_programs_path(@company.slug) },
      { name: @program.name, path: company_program_path(@company.slug, @program) }
    ]
    @coaches = @program.coaches
  end

  private

  def find_company
    @company ||= Company.find_by!(slug: params[:company_slug])
  end

  def find_program
    @program ||= @company.coaching_programs.find(params[:id])
  end
end
