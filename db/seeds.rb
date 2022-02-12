# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Order.destroy_all
Product.destroy_all
User.destroy_all
puts "Deleted everything"
user = User.create!(email: 'email@mail.ru', password: '123456')
puts "Created a user"
product = Product.create!(name: 'Dog food', description: 'Very tasty dog food')
puts "Created a product"
order = Order.create!(user: user, product: product)

puts "Created an order"
