class CreateJoinTableCoachesCoachingPrograms < ActiveRecord::Migration[7.2]
  def change
    create_join_table :coaches, :coaching_programs do |t|
      # t.index [:coach_id, :coaching_program_id]
      # t.index [:coaching_program_id, :coach_id]
    end
  end
end
