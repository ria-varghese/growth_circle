class Coach < User
  default_scope { where(role: :coach) }
  has_and_belongs_to_many :coaching_programs, join_table: "coaches_coaching_programs", foreign_key: "coach_id"
  has_many :enrollments, class_name: "Employee"

  rails_admin do
    list do
      field :name
      field :email
      field :coaching_programs
      field :enrollments
      field :active
    end

    edit do
      field :name
      field :email do
        required true
      end
      field :coaching_programs
      field :enrollments
      field :password
      field :password_confirmation
      field :active
    end
  end
end
