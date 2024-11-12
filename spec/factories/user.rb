FactoryBot.define do
  factory :user do
    name { Faker::Name }
    email { Faker::Email }
    password { "password" }
    password_confirmation { "password" }
    active { true }
    role { :employee }
  end
end
