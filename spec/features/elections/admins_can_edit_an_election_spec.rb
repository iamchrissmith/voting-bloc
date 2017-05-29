require 'rails_helper'

RSpec.describe "an admin can edit an election" do
  context "possible before the election started" do
    context "when viewed from the elections index page" do
      it "admins can edit election"
      it "users cannot edit election" do
        user = create(:user)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        Timecop.freeze(election.start_date - 1) do
          visit elections_path

          expect(current_path).to eq elections_path
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end

      it "candidates cannot edit election" do
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

    context "when viewed from the elections show page" do
      it "admins can edit election"
      it "users cannot edit election" do
        user = create(:user)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        Timecop.freeze(election.start_date - 1) do
          visit election_path(election)

          expect(current_path).to eq election_path(election)
          expect(page).not_to have_link "Delete", href: admin_election_path(election)
        end
      end

      it "candidates cannot edit election" do
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

    context "not possible before the election started" do
      context "when viewed from the elections index page" do
        it "admins cannot edit election"
      end
      context "when viewed from the elections show page" do
        it "admins cannot edit election"
      end
    end
  end
end
