# Create Users
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(minimum_length = 6)
  )
end

users = User.all

20.times do
  Order.create!(
    description: Faker::Lorem.sentence(word_count = 6),
    shipping_charge: Faker::Number.number(3),
    track_package: Faker::Internet.url,
    user: users.sample
  )
end
  
puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Order.count} orders created"


