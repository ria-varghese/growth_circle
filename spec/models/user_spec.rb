require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a user' do
    user = create(:user)
    expect(user).to be_valid
  end
end
