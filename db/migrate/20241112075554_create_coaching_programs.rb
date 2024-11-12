class CreateCoachingPrograms < ActiveRecord::Migration[7.2]
  def change
    create_table :coaching_programs do |t|
      t.string :name
      t.text :description
      t.bigint :company_id
      t.boolean :active, default: true, null: false
      t.timestamps
    end

    add_index :coaching_programs, :company_id
  end
end
