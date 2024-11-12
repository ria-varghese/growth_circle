class AddCoachIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :coach_id, :bigint
  end
end
