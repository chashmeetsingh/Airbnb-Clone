# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5000.times do
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    username: Faker::Internet.user_name + Faker::Internet.password(2),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    country: Faker::Address.country,
    address: Faker::Address.street_address,
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude,
    city: Faker::Address.city,
    state: Faker::Address.state,
    phone_no: Faker::PhoneNumber.cell_phone
  )
end