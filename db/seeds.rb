require 'faker'

Ballot.destroy_all
Vote.destroy_all
User.destroy_all
Election.destroy_all

users = []
5.times do |num|
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{num}",
    password: 'user'
  )
end

candidates = []
4.times do |num|
  candidates << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'abc123',
    role: 1
  )
end

past_elections = []
3.times do |num|
   election = Election.create!(
    topic: Faker::Lorem.sentence,
    description: Faker::Lorem.sentences(4).join,
    start_date: Faker::Date.backward(15),
    end_date: Faker::Date.backward(10),
    candidates: candidates
  )
  past_elections << election

  # election.votes << Vote.create!(
  #   user_id: users.shuffle.first.id
  #   recipient_id: candidates.shuffle.first.id
  #   election:
  # )
end


active_election = Election.create!(
  topic: Faker::Lorem.sentence,
  description: Faker::Lorem.sentences(4).join,
  start_date: Faker::Date.backward(5),
  end_date: Faker::Date.forward(10),
  candidates: candidates
)
upcoming_election = Election.create!(
  topic: Faker::Lorem.sentence,
  description: Faker::Lorem.sentences(2),
  start_date: Faker::Date.backward(15),
  end_date: Faker::Date.backward(10),
  candidates: []
)

admin = User.create!(
  first_name: 'admin',
  last_name: 'admin',
  email: 'admin',
  password: 'admin',
  role: 2
)

admin2 = User.create!(
  first_name: 'admin',
  last_name: 'admin',
  email: 'admin@admin.com',
  password: 'admin',
  role: 2
)

demo_user = User.create!(
  first_name: 'demo',
  last_name: 'demo',
  email: 'demo@demo.com',
  password: 'demo'
)
