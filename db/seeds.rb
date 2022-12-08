# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require "open-uri"

Faker::Config.locale = 'es'


puts 'Destroying previous users and items 🌱'

Review.destroy_all
Booking.destroy_all
Item.destroy_all
User.destroy_all

puts 'Seeding db 🌱'

7.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    username: Faker::Internet.username(specifier: 5..10),
    description: Faker::TvShows::SiliconValley.quote,
    tokens: 100,
    password: "123456",
    address: Faker::Address.city,
    profile_picture: Faker::LoremFlickr.image
  )
  5.times do
    item = Item.new(
      name: Faker::Commerce.product_name,
      category: Item::CATEGORIES.sample,
      condition: Item::CONDITION.sample,
      description: Faker::Lorem.sentence(word_count: 15),
      item_picture: Faker::LoremFlickr.image,
      price: [5, 10, 20, 50, 100].sample,
      user_id: user.id
    )
      
    file = URI.open("https://source.unsplash.com/random/?#{item.category}")
    item.photo.attach(io: file, filename: "#{item.name}.png", content_type: "image/png")
    item.save
  end
  puts "User #{user.first_name} has been created with an item"
end

puts 'Finished ✅'
