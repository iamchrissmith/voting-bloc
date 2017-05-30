FactoryGirl.define do
  factory :election do
    start_date "01/01/2017"
    end_date "01/01/2017"
    topic "Election Topic"
    candidates []

    factory :election_with_candidates, parent: :election do
      transient do
        candidate { FactoryGirl.create(:candidate) }
      end

      after(:create) do |election, evaluator|
        election.candidates << evaluator.candidate
      end
    end
  end
end
