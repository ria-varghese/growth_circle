module Redirections
  extend ActiveSupport::Concern

  included do
      def after_sign_in_path_for(resource)
        flash[:notice] = "Welcome back, #{current_user.name}!"
        binding.pry
        if current_user.admin?
          rails_admin_path
        elsif current_user.employee?
          employee = Employee.find(current_user.id)
          company_programs_path(employee.company.slug)
        else
          root_path
        end
      end

      def after_sign_out_path_for(resource)
        flash[:alert] = "You have successfully signed out."
        root_path
      end
  end
end
