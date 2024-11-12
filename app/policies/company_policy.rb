class CompanyPolicy < ApplicationPolicy
  def show_company_page?
    user.employee? && record.id == user.company_id
  end
end
