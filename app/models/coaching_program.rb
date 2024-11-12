class CoachingProgram < ApplicationRecord
  has_and_belongs_to_many :companies, dependent: :nullify
  has_and_belongs_to_many :coaches, join_table: "coaches_coaching_programs", association_foreign_key: "coach_id", dependent: :nullify


  rails_admin do
    list do
      field :name
      field :description
      field :companies
      field :coaches
      field :active
    end

    edit do
      field :name
      field :description
      field :coaches do
        associated_collection_scope do
          Proc.new { |scope| User.active.coaches }
        end
      end
      field :companies
      field :active
    end

    show do
      field :name
      field :description
      field :coaches do
        pretty_value do
          bindings[:view].render(partial: "coaching_programs/coaches_list", locals: { coaches: value })
        end
      end
      field :companies do
        pretty_value do
          bindings[:view].render(partial: "coaching_programs/companies_list", locals: { companies: value })
        end
      end
    end
  end
end
