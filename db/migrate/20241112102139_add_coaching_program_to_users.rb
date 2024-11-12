class AddCoachingProgramToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :coaching_program, foreign_key: true
  end
end
