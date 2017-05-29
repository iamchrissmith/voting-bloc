require 'faker'

User.destroy_all
Election.destroy_all
Ballot.destroy_all

5.times do |num|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123abc'
  )
end

3.times do |num|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'abc123',
    role: 1
  )
  election = Election.create!(
    topic: Faker::Lorem.sentence,
    description: Faker::Lorem.sentences(2),
    start_date: Faker::Date.backward(5),
    end_date: Faker::Date.forward(10)
  )
  election.candidates << user
end

Election.create!(
  topic: Faker::Lorem.sentence,
  description: Faker::Lorem.sentences(2),
  start_date: Faker::Date.backward(15),
  end_date: Faker::Date.backward(10),
  candidates: []
)

User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'admin@admin.com',
  password: 'admin123abc',
  role: 2
)
