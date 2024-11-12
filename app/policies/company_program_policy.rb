class CompanyProgramPolicy < ApplicationPolicy
  def index?
    user.employee? && user.company == record
  end
end
