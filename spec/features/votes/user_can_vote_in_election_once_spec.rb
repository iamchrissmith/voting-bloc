require 'rails_helper'

RSpec.describe "" do
  context "when the user hasn't already voted" do
    it "a user can vote in an election" do
      user = create(:user)
      election = create(:election_with_candidates)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Timecop.freeze(election.end_date - 1) do
        visit election_path(election)

        expect(page).to have_content "Select the candidate you would like to vote for:"
        page.check election.candidates.first.full_name

        click_button "Vote"

        expect(current_path).to eq election_path(election)

        expect(page).to have_content "You have voted for: #{election.candidates.first.full_name} in this election"
        expect(page).not_to have_button "Vote"
      end
    end
  end

  context "when the user has already voted" do
    it "a user can't vote in an election"
  end
end
