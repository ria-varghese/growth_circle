class Company < ApplicationRecord
  has_many :employees, class_name: "User", dependent: :destroy

  validates :name, presence: true
  validates :slug, uniqueness: true
  validate :slug_not_changed

  before_create :set_slug

  rails_admin do
   list do
      field :name
      field :landing_page_link do
        label "URL"
        formatted_value do
          bindings[:object].landing_page_link
        end
      end
      field :description
      field :employees do
        pretty_value do
          value.count
        end
      end
    end

    show do
      field :name
      field :description
      field :employees do
        pretty_value do
          # bindings[:view].render(partial: "company/employees_list", locals: { employees: value })
        end
      end
    end

    edit do
      field :name
      field :description
      field :employees do
        associated_collection_scope do
          company = bindings[:object]
          Proc.new { |scope| scope.where(role: :employee, active: true, company: company) }
        end
      end
    end
  end

  def landing_page_link
    "<a href='/companies/#{slug}/programs' target='_blank'>Landing Page</a>".html_safe
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
