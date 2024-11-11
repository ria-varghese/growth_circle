class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, coach: 1, employee: 2 }

  validates :name, presence: true
  validates :role, presence: true
  validates :password_confirmation, presence: true

  rails_admin do
    list do
      field :name
      field :email
      field :role
      field :active
    end

    edit do
      field :name
      field :email
      field :password
      field :password_confirmation
      field :role, :enum do
        enum do
          array = User.roles.map do |k, v|
            [ I18n.t("user.roles.#{k}"), v ]
          end
          Hash[array]
        end
      end
      field :active
    end
  end
end
