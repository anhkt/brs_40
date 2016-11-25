User.create!(name: "ducbka",
  email: "ducbka@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true)

20.times do |n|
  name  = Faker::Name.name
  email = "project-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
  
16.times do |n|
  name = "category_name-#{n+1}"
  Category.create!(category_name: name)  
end

categories = Category.take(16)
16.times do
  title = Faker::Book.title
  author = Faker::Book.author
  description = Faker::Lorem.characters(100)
  date = Faker::Date.between(2.days.ago, Date.today)
  number_page = Faker::Number.between(1, 100)
  categories.each{ |cat|
    cat.books.create!(title: title,author: author,
      publish_date: date, number_of_page: number_page,description: description)
  }
end

users = User.all
user = User.first
following = users[1..10]
followers = users[2..7]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
