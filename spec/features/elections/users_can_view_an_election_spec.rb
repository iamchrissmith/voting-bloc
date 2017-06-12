require 'rails_helper'

RSpec.describe "a user can view an election" do
  context "before an election" do
    it "they can see election details and pre-election message" do
      user = create(:user)
      election = create(:election)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Timecop.freeze(election.start_date - 1) do
        visit elections_path

        click_link "View"

        expect(current_path).to eq election_path(election)
        expect(page).to have_content election.topic
        expect(page).to have_link "All Elections", href: elections_path

        expect(page).not_to have_content 'Select the candidate you would like to vote for:'
        expect(page).not_to have_content 'You voted in this election for:'
        expect(page).not_to have_content 'This election is closed.'
        expect(page).to have_content 'Voting has not yet started in this election.'
      end
    end
  end

  context "during an election" do
    it "they can see voting details" do
      user = create(:user)
      election = create(:election)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Timecop.freeze(election.end_date - 1) do
        visit elections_path

        click_link "View"

        expect(current_path).to eq election_path(election)
        expect(page).to have_content election.topic
        expect(page).to have_link "All Elections", href: elections_path

        expect(page).to have_content 'Select the candidate you would like to vote for:'
        expect(page).not_to have_content 'You voted in this election for:'
        expect(page).not_to have_content 'This election is closed.'
        expect(page).not_to have_content 'Voting has not yet started in this election.'
      end
    end
  end

  context "after an election" do
    it "they can see closed election details" do
      user = create(:user)
      election = create(:election)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Timecop.freeze(election.end_date + 1) do
        visit elections_path

        click_link "View"

        expect(current_path).to eq election_path(election)
        expect(page).to have_content election.topic
        expect(page).to have_link "All Elections", href: elections_path

        expect(page).not_to have_content 'Select the candidate you would like to vote for:'
        expect(page).not_to have_content 'You voted in this election for:'
        expect(page).to have_content 'This election is closed.'
        expect(page).not_to have_content 'Voting has not yet started in this election.'
      end
    end
  end
end
