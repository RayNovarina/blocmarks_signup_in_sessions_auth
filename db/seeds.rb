# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include RandomData

puts "Seeding database:\n"
puts 'Seeding Users, Topics'

# Create Users
5.times do
  User.create!(
    name:     RandomData.random_name,
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end
# Create an admin user
admin_user = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     :admin
)

# Create a member user
member_user = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld',
  role:     :member
)

# Create a Member user with a valid email address/gravatar
test_user = User.create!(
  name:     'Test User',
  email:    'RNova94037@Gmail.com',
  password: 'password',
  role:     :member
)
#
# Create Topics 10
puts 'Seeding topics'
# 10.times do
#  Topic.create!(
#    name:        RandomData.random_sentence(5, 250),
#    description: RandomData.random_paragraph(15, 500)
#  )
# end
# topics = Topic.all
#
puts 'Seed finished'
puts "#{User.count} users created"
puts "'Test user' (credentials):   '#{test_user.name}' (#{test_user.email}/#{test_user.password})"
puts "'Admin user' (credentials):  '#{admin_user.name}' (#{admin_user.email}/#{admin_user.password})"
puts "'Member user' (credentials): '#{member_user.name}' (#{member_user.email}/#{member_user.password})"
# puts "#{Topic.count} topics created"
