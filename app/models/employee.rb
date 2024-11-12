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
end
