class CreateJoinTableCompaniesCoachingPrograms < ActiveRecord::Migration[7.2]
  def change
    create_join_table :companies, :coaching_programs do |t|
      # t.index [:company_id, :coaching_program_id]
      # t.index [:coaching_program_id, :company_id]
    end
  end
end
