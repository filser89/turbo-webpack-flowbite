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
animals = %w[dog cat pig goat cow turtle]
animals.each do |animal|
  product = Product.create!(
    name: "#{animal} food",
    description: "Very tasty #{animal} food",
    quantity: (1...20).to_a.sample
  )
  puts "Created a product #{product.name}"
  order = Order.create!(user:, product:)
  puts "Created an order for #{product.name}"
end
