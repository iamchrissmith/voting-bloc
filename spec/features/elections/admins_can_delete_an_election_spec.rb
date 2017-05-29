require 'rails_helper'

RSpec.describe "an admin can delete an election" do
  context "when the election hasn't started" do
    it "they can delete election from elections page" do
      admin = create(:admin)
      election = create(:election)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      Timecop.freeze(election.start_date - 1) do
        visit elections_path

        click_link "Delete"

        expect(current_path).to eq elections_path
        expect(page).to have_content "Election '#{election.topic}' Deleted!"
        expect(page).not_to have_link "View", election_path(election)
      end
    end
  end

  context "when the election has started" do
    it "the election cannot be deleted" do
      admin = create(:admin)
      election = create(:election)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      Timecop.freeze(election.start_date + 1) do
        visit elections_path

        expect(current_path).to eq elections_path
        expect(page).not_to have_link "Delete", admin_election_path(election)
      end
    end
  end

  context "when a users visits the page" do
    xit "they cannot delete an election" do

    end
  end
end
