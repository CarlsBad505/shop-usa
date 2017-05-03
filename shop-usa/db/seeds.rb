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
    name: "Google Home",
    price: 114,
    active: true,
    photo: "https://s3-us-west-2.amazonaws.com/shop-usa/Google-Home.jpeg",
    description: "Ask it questions. Tell it to do things. It's your own Google, always ready to help. Just start by saying, \'Ok Google.\'",
    shipping: 118
)

Product.create!(
    id: 2,
    name: "Dell Inspiron i3552",
    price: 259,
    active: true,
    photo: "https://s3-us-west-2.amazonaws.com/shop-usa/Dell-Inspiron-Laptop.jpeg",
    description: "Intel Celeron N3050 Processor, 4GB memory, 500GB hard drive, 15.6\" display, Memory Card Reader, WiFi",
    shipping: 202
)

Product.create!(
    id: 3,
    name: "Due Menti Sydney Collection - Giselle",
    price: 78,
    active: true,
    photo: "https://s3-us-west-2.amazonaws.com/shop-usa/Due-Menti.jpeg",
    description: "Beaded wrap bracelet with gold and blue accents, brass accent bead detail. Can be worn as a necklace. Length: approximately 26” with a 2” chain extension/6.5” wrapped",
    shipping: 113
)

Product.create!(
    id: 4,
    name: "Arbonne Skin Care",
    price: 72,
    active: true,
    photo: "https://s3-us-west-2.amazonaws.com/shop-usa/RE9-Advanced-Restorative.jpg",
    description: "NEW! RE9 Advanced Restorative Cream SPF 20 Sunscreen",
    shipping: 111
)

Product.create!(
    id: 5,
    name: "Spalding Basketball",
    price: 39,
    active: true,
    photo: "https://s3-us-west-2.amazonaws.com/shop-usa/Spalding-Basketball.jpeg",
    description: "Spalding Indoor / Outdoor Basketball",
    shipping: 113
)

OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"


puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Order.count} orders created"
puts "#{Product.count} products created"
puts "#{OrderStatus.count} order statuses created"
