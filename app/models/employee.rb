class Employee < User
  default_scope { where(role: :employee) }
  belongs_to :company
  belongs_to :coaching_program, optional: true
end
