class Coach < User
  default_scope { where(role: :coach) }
  has_and_belongs_to_many :coaching_programs, join_table: "coaches_coaching_programs", foreign_key: "coach_id"
end
