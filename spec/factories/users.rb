FactoryGirl.define do
  sequence(:email) { |n| "first.last#{n}@test.com"}

  factory :user do
    first_name "User First"
    last_name "Last"
    email
    password "pass"
  end

  factory :candidate, class: User do
    first_name "Candidate First"
    last_name "Last"
    email
    password "pass"
    role 1
    profile "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  end

  factory :admin, class: User do
    first_name "Admin First"
    last_name "Last"
    email
    password "pass"
    role 2
  end
end
