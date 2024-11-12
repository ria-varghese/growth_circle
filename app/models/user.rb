class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, coach: 1, employee: 2 }

  validates :name, presence: true
  validates :role, presence: true

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
end
