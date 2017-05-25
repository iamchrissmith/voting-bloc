FactoryGirl.define do
  factory :user do
    first_name "First"
    last_name "Last"
    email "first.last@test.com"
    password "pass"
  end

  factory :candidate, class: User do
    first_name "First"
    last_name "Last"
    email "first.last@test.com"
    password "pass"
    role 1
  end

  factory :admin, class: User do
    first_name "First"
    last_name "Last"
    email "first.last@test.com"
    password "pass"
    role 2
  end
end
