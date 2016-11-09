User.create!(name: "ducbka",
  email: "ducbka@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "project-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

