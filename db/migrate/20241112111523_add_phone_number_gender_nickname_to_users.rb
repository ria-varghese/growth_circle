class AddPhoneNumberGenderNicknameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :gender, :string
    add_column :users, :nickname, :string
  end
end
