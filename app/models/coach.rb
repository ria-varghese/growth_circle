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

  def self.ransackable_attributes(auth_object = nil)
    [ "active", "coach_id", "coaching_program_id", "coaching_requirements", "company_id", "created_at", "email", "encrypted_password", "gender", "id", "id_value", "name", "nickname", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at" ]
  end
end
