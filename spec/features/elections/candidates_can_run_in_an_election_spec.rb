require 'rails_helper'

RSpec.describe "candidates can run in an election" do
  context "when they are a candidate" do
    context "if they are not already running in the election and election hasn't started" do
      it "they can run" do
        candidate = create(:candidate)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)
        Timecop.freeze(election.start_date - 1) do
          visit election_path (election)

          expect(page).to have_content "Run in this Election"

          click_link "Run in this Election"

          expect(current_path).to eq election_path(election)
          expect(page).to have_content "You are now running in this election!"
          expect(page).to have_content full_name(candidate)
        end
      end
    end

    context "if they are already running" do
      it "they cannot run" do
        candidate = create(:candidate)
        election = create(:election, candidates: [candidate])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)
        Timecop.freeze(election.start_date - 1) do
          visit election_path (election)

          expect(page).not_to have_content "Run in this Election"
        end
      end
    end

    context "if the election has started" do
      it "they cannot run" do
        candidate = create(:candidate)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

        Timecop.freeze(election.start_date + 1) do
          visit election_path (election)

          expect(page).not_to have_content "Run in this Election"
        end
      end
    end
  end
end
