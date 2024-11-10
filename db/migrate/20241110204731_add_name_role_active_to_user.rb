class AddNameRoleActiveToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :integer, null: false
    add_column :users, :active, :boolean, null: false, default: true
  end
end
