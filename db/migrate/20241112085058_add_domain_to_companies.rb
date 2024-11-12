class AddDomainToCompanies < ActiveRecord::Migration[7.2]
  def change
    add_column :companies, :domain, :string, null: false
  end
end
