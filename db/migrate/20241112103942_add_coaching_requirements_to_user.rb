class AddCoachingRequirementsToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :coaching_requirements, :text
  end
end
