# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Company.destroy_all
CoachingProgram.destroy_all

abc_company = Company.create!(
  name: "ABC Company",
  description: "ABC Company is a dynamic and forward-thinking organization specializing in innovative solutions across multiple industries. With a commitment to excellence and a focus on customer satisfaction, ABC Company provides a wide range of products and services designed to meet the diverse needs of its clients. From cutting-edge technology solutions to high-quality consumer goods, ABC Company consistently delivers value, reliability, and expertise. Our mission is to empower businesses and individuals alike with tools that drive growth, efficiency, and success in an ever-evolving global marketplace."
)
puts "Created ABC Company"

xyz_company = Company.create!(
  name: "XYZ Company",
  description: "XYZ Company is a dynamic and forward-thinking organization specializing in innovative solutions across multiple industries. With a commitment to excellence and a focus on customer satisfaction, XYZ Company provides a wide range of products and services designed to meet the diverse needs of its clients. From cutting-edge technology solutions to high-quality consumer goods, XYZ Company consistently delivers value, reliability, and expertise. Our mission is to empower businesses and individuals alike with tools that drive growth, efficiency, and success in an ever-evolving global marketplace."
  )
puts "Created XYZ Company"

# Generating Admin
User.create!(
  name: "Admin",
  email: "admin@example.com",
  role: :admin,
  password: "password",
  password_confirmation: "password"
  )

puts "Created Admin user"

# Generating ABC Employees
10.times do |i|
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email(name: "employee#{i+1}"),
    role: :employee,
    company: abc_company,
    password: "password",
    password_confirmation: "password"
    )
  puts "Created ABC Company's employee #{user.name}"
end

puts "Created 10 ABC Company's employees"

# Generating XYZ Employees
10.times do |i|
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email(name: "employee#{i+1}"),
    role: :employee,
    company: xyz_company,
    password: "password",
    password_confirmation: "password"
    )
  puts "Created XYZ Company's employee #{user.name}"
end

puts "Created 10 XYZ Company's employees"

# Generating Coaches
10.times do |i|
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email(name: "coach#{i+1}"),
    role: :coach,
    password: "password",
    password_confirmation: "password"
  )
  puts "Created Coach #{user.name}"
end


# Generating Coaching programs
3.times do |i|
  coaches = User.coaches.sample(3)
  coaching_program = CoachingProgram.create!(
    name: "Coaching Program #{i}",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis, sapien vitae auctor efficitur, turpis felis tincidunt neque, ac pharetra sem lectus id felis. Morbi vulputate scelerisque velit, at gravida lorem. Sed ut diam non ligula cursus fermentum vel in magna. Aenean nec tortor mollis, posuere velit non, dictum mi. Proin eget facilisis metus. Nunc condimentum urna turpis, ac egestas eros consectetur ac. Donec dapibus erat ut diam posuere, ac tincidunt elit consequat. Nullam cursus orci et orci varius tempor. Vestibulum tristique quam sapien, nec gravida felis fermentum sed. Cras auctor malesuada libero sit amet fermentum. Sed ut ante at felis sollicitudin gravida. Aliquam erat volutpat. Vivamus ac metus at ante gravida lacinia id id felis. Suspendisse in nisi in ante tincidunt vestibulum eget a ipsum. Aenean auctor mollis lectus sed tincidunt. In id magna metus. Etiam fringilla velit vitae erat laoreet, et faucibus magna viverra. Sed non nisi quis sem posuere laoreet. Aenean a metus ut dolor tincidunt laoreet eget vel sem. Pellentesque nec mi tempor, tempor odio a, luctus orci.",
    companies: [ abc_company, xyz_company ],
    coaches:  coaches
  )
  puts "Created Coaching Program #{coaching_program.name} for ABC Company and XYZ company with coaches - #{coaches.pluck(:name).join(", ")}"
end

puts "Created 3 coaching programs"
