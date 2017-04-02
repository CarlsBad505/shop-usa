# Create Users
# 5.times do
#   User.create!(
#     email: Faker::Internet.email,
#     password: Faker::Internet.password(minimum_length = 6)
#   )
# end

User.create!(
    email: 'carl@tabrific.com',
    password: 'Yellow123',
    admin: false
  )

User.create!(
    email: 'peter.sidles@courierusallc.com',
    password: 'temporary9137',
    admin: true
  )

Product.create!(
    id: 1,
    name: "Camera",
    price: 89.99,
    active: true
)

Product.create!(
    id: 2,
    name: "iPhone 7",
    price: 299.99,
    active: true
)

Product.create!(
    id: 3,
    name: "Samsung Smart Watch",
    price: 250.49,
    active: true
)

OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"

# users = User.all

# 20.times do
#   Order.create!(
#     description: Faker::Lorem.sentence(word_count = 6),
#     shipping_charge: Faker::Number.number(3),
#     track_package: Faker::Internet.url,
#     user: users.sample
#   )
# end

# 5.times do
#   Order.create!(
#     description: Faker::Lorem.sentence(word_count = 6),
#     shipping_charge: Faker::Number.number(3),
#     track_package: Faker::Internet.url,
#     user: User.last
#   )
# end

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Order.count} orders created"
puts "#{Product.count} products created"
puts "#{OrderStatus.count} order statuses created"
