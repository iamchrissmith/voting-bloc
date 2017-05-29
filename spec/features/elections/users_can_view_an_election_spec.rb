require 'rails_helper'

RSpec.describe "a user can view an election" do
  it "they can see election details" do
    user = create(:user)
    election = create(:election)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit elections_path

    click_link "View"

    expect(current_path).to eq election_path(election)
    expect(page).to have_content election.topic
    expect(page).to have_link "All Elections", href: elections_path
  end

  context "when they are a candidate" do
    context "if they are not already running in the election" do
      it "they can run" do
        candidate = create(:candidate)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

        visit election_path (election)

        expect(page).to have_content "Run in this Election"
      end
    end

    context "if they are already running" do
      it "they cannot run" do
        candidate = create(:candidate)
        election = create(:election, candidates: [candidate])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

        visit election_path (election)

        expect(page).not_to have_content "Run in this Election"
      end
    end
  end
end
