require 'rails_helper'

RSpec.describe "Voting by users" do
  context "when the user hasn't already voted" do
    it "a user can vote in an election" do
      user = create(:user)
      election = create(:election_with_candidates)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Timecop.freeze(election.end_date - 1) do
        visit election_path(election)

        expect(page).to have_content "Select the candidate you would like to vote for:"
        page.choose election.candidates.first.full_name

        click_button "Vote"

        expect(current_path).to eq election_path(election)

        expect(page).to have_content "Your Vote has been recorded!"
        expect(page).to have_content "You voted in this election for: #{election.candidates.first.full_name}"
        expect(page).not_to have_button "Vote"
      end
    end
  end

  context "when the has ended" do
    it "a user cannot vote in the election" do
      user = create(:user)
      election = create(:election_with_candidates)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Timecop.freeze(election.end_date + 1) do
        visit election_path(election)

        expect(page).to have_content "This election is closed."
        expect(page).not_to have_content "You voted in this election for: #{election.candidates.first.full_name}"
        expect(page).not_to have_button "Vote"
      end
    end
  end

  context "when the has not started" do
    it "a user cannot vote in the election" do
      user = create(:user)
      election = create(:election_with_candidates)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Timecop.freeze(election.start_date - 1) do
        visit election_path(election)

        expect(page).to have_content "Voting has not yet started in this election."
        expect(page).not_to have_content "You voted in this election for: #{election.candidates.first.full_name}"
        expect(page).not_to have_button "Vote"
      end
    end
  end
end
