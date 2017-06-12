require 'rails_helper'

RSpec.describe "an admin can delete an election" do
  context "when viewed from the elections index" do
    context "when the election hasn't started" do
      it "they can delete election" do
        admin = create(:admin)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        Timecop.freeze(election.start_date - 1) do
          visit elections_path

          click_link "Delete"

          expect(current_path).to eq elections_path
          expect(page).to have_content "Election '#{election.topic}' Deleted!"
          expect(page).not_to have_link "View", href: election_path(election)
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
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end
    end

    context "when a non-admin visits the page" do
      it "users cannot delete an election" do
        user = create(:user)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        Timecop.freeze(election.start_date - 1) do
          visit elections_path

          expect(current_path).to eq elections_path
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end
      it "candidates cannot delete an election" do
        candidate = create(:candidate)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

        Timecop.freeze(election.start_date - 1) do
          visit elections_path

          expect(current_path).to eq elections_path
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end
    end
  end
  context "when viewed from the election show" do
    context "when the election hasn't started" do
      it "they can delete election" do
        admin = create(:admin)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        Timecop.freeze(election.start_date - 1) do
          visit election_path(election)

          click_link "Delete"

          expect(current_path).to eq elections_path
          expect(page).to have_content "Election '#{election.topic}' Deleted!"
          expect(page).not_to have_link "View", href: election_path(election)
        end
      end
    end

    context "when the election has started" do
      it "the election cannot be deleted" do
        admin = create(:admin)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        Timecop.freeze(election.start_date + 1) do
          visit election_path(election)

          expect(current_path).to eq election_path(election)
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end
    end

    context "when a non-admin visits the page" do
      it "users cannot delete an election" do
        user = create(:user)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        Timecop.freeze(election.start_date - 1) do
          visit election_path(election)

          expect(current_path).to eq election_path(election)
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end
      it "candidates cannot delete an election" do
        candidate = create(:candidate)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

        Timecop.freeze(election.start_date - 1) do
          visit election_path(election)

          expect(current_path).to eq election_path(election)
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end
    end
  end
end
