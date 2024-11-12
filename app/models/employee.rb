class Employee < User
  default_scope { where(role: :employee) }
  belongs_to :company
  belongs_to :coaching_program, optional: true
  belongs_to :coach, optional: true

  rails_admin do
    list do
      field :name
      field :email
      field :company
      field :coaching_program
      field :phone_number
      field :gender
      field :nickname
      field :active
    end

    edit do
      field :name
      field :email do
        required true
      end
      field :role
      field :password
      field :password_confirmation
      field :company
      field :coaching_program
      field :coach
      field :active
    end
  end

  def unenroll
    update!(coaching_program: nil)
  end

  def enroll(program)
    update!(coaching_program: program)
  end

  def enrolled_in?(program)
    coaching_program&.id == program.id
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "active", "coach_id", "coaching_program_id", "coaching_requirements", "company_id", "created_at", "email", "encrypted_password", "gender", "id", "id_value", "name", "nickname", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "coach", "coaching_program", "company" ]
  end
end
