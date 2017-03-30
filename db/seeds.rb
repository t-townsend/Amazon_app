# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1000.times do
  Product.create title: Faker::Commerce.product_name,
                  description: Faker::Hipster.sentence,
                  price: Faker::Commerce.price
end

puts Cowsay.say 'Created 1000 products', :elephant


100.times do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email
end

puts Cowsay.say 'Created 100 users', :dragon
