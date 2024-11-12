class Company < ApplicationRecord
  has_many :employees
  has_and_belongs_to_many :coaching_programs, dependent: :nullify

  validates :name, presence: true
  validates :slug, uniqueness: true
  validate :slug_not_changed

  before_create :set_slug

  rails_admin do
    list do
      field :name do
        pretty_value do
          bindings[:view].render(partial: "companies/landing_page_url", locals: { company: bindings[:object] })
        end
      end
      field :description
      field :coaching_programs
      field :employees do
        pretty_value do
          value.count
        end
      end
    end

    show do
      field :name
      field :description
      field :coaching_programs
      field :employees do
        pretty_value do
          bindings[:view].render(partial: "companies/employees_list", locals: { employees: value })
        end
      end
    end

    edit do
      field :name
      field :description
      field :coaching_programs
      field :employees
    end
  end

  private

  def set_slug
    title_slug = name.parameterize
    latest_task_slug = Company.where(
      "slug REGEXP ?",
      "^#{title_slug}$|^#{title_slug}-[0-9]+$",
    ).order("LENGTH(slug) DESC", slug: :desc).first&.slug
    slug_count = 0
    if latest_task_slug.present?
      slug_count = latest_task_slug.split("-").last.to_i
      only_one_slug_exists = slug_count == 0
      slug_count = 1 if only_one_slug_exists
    end
    slug_candidate = slug_count.positive? ? "#{title_slug}-#{slug_count + 1}" : title_slug
    self.slug = slug_candidate
  end

  def slug_not_changed
    if will_save_change_to_slug? && self.persisted?
      errors.add(:slug, "is immutable!")
    end
  end
end
