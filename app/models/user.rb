class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, coach: 1, employee: 2 }

  belongs_to :company, optional: true

  has_and_belongs_to_many :coaching_programs, join_table: "coaches_coaching_programs", foreign_key: "coach_id"

  validates :name, presence: true
  validates :role, presence: true
  validate :company_assignment

  scope :active, -> { where(active: true) }
  scope :admins, -> { where(role: :admin) }
  scope :coaches, -> { where(role: :coach) }
  scope :employees, -> { where(role: :employee) }

  rails_admin do
    list do
      field :name
      field :email
      field :company
      field :role
      field :active

      scopes [ :all, :admin, :coaches, :employees ]
    end

    edit do
      field :name
      field :email do
        required true
      end
      field :company
      field :role
      field :password do
        visible do
          bindings[:object].new_record? || bindings[:object].admin?
        end
        required do
          bindings[:object].new_record?
        end
      end
      field :password_confirmation do
        visible do
          bindings[:object].new_record? || bindings[:object].admin?
        end
        required do
          bindings[:object].new_record? ? true : false
        end
      end
      field :active
    end
  end

  private

  def password_required?
    new_record? ? super : false
  end

  def company_assignment
    if employee?
      errors.add(:company, "must be assigned to an employee") if company.blank?
    else
      errors.add(:company, "cannot be assigned to #{self.role} user") if company.present?
    end
  end
end
