class CompanyProgramsController < ApplicationController
  # authorize_user only employees of this company can access this page
  layout "company_landing"

  before_action :find_company

  def index
    @breadcrumbs = [
      { name: "Programs", path: company_programs_path(@company.slug) }
    ]
    render
  end

  private

  def find_company
    @company ||= Company.find_by!(slug: params[:company_slug])
  end
end
