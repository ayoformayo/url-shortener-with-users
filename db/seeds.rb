require 'faker'

User.delete_all

10.times do
  User.create!(:email => Faker::Internet.email, :password => Faker::Company.bs, :name => Faker::Name.name)
end
