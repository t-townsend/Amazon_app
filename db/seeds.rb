# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Books', 'TV Shows', 'Movies', 'Clothes', 'Music', 'Food'].each do |category|
  Category.create(name: category)
end

# Create users
20.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: '12345678',
              password_confirmation: '12345678'
  )
end
puts Cowsay.say 'Created 50 users', :ghostbusters


# Create Products
100.times do
  category = Category.all.sample
  user = User.all.sample

  p = Product.create(title: Faker::Hacker.say_something_smart,
                     description: Faker::Hipster.paragraph,
                     price: rand(100),
                     category_id: category.id,
                     user_id: user.id
  )
end

puts Cowsay.say 'Created 100 products', :dragon

# Create Reviews
Product.all.each do |product|
  5.times do
    user = User.all.sample

    product.reviews.create(rating: rand(6),
                           body: Faker::Hipster.paragraph,
                           user_id: user.id
    )
    puts "Review created!"
  end
end
puts Cowsay.say 'Created lots of reviews', :stimpy
