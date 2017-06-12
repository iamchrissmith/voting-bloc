require 'rails_helper'

RSpec.describe "an admin can edit an election" do
  context "before the election started" do
    context "when viewed from the elections index page" do
      it "admins can edit election" do
        admin = create(:admin)
        candidate = create(:candidate)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        Timecop.freeze(election.start_date - 1) do
          visit elections_path

          click_link "Edit"

          expect(current_path).to eq edit_admin_election_path(election)

          fill_in "Topic", with: "New Topic"
          fill_in "Description", with: "New Description"
          page.check full_name(candidate)

          click_button "Update Election"

          expect(page).to have_content "Election Updated!"
          expect(page).to have_content "New Topic"
          expect(page).to have_content "New Description"
          expect(page).to have_content full_name(candidate)
        end
      end
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
      it "admins can edit election" do
        admin = create(:admin)
        candidate = create(:candidate)
        election = create(:election, candidates: [candidate])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        Timecop.freeze(election.start_date - 1) do
          visit election_path(election)

          click_link "Edit"

          expect(current_path).to eq edit_admin_election_path(election)

          fill_in "Topic", with: "New Topic"
          fill_in "Description", with: "New Description"
          page.uncheck full_name(candidate)

          click_button "Update Election"

          expect(page).to have_content "Election Updated!"
          expect(page).to have_content "New Topic"
          expect(page).to have_content "New Description"
          expect(page).not_to have_content full_name(candidate)
        end
      end
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
  end
  context "after the election started" do
    context "when viewed from the elections index page" do
      it "admins cannot edit election" do
        admin = create(:admin)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        Timecop.freeze(election.start_date + 1) do
          visit elections_path

          expect(current_path).to eq elections_path
          expect(page).not_to have_link "Edit", href: edit_admin_election_path(election)
        end
      end
    end

    context "when viewed from the elections show page" do
      it "admins cannot edit election" do
        admin = create(:admin)
        election = create(:election)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        Timecop.freeze(election.start_date + 1) do
          visit election_path(election)

          expect(page).not_to have_link "Edit", href: edit_admin_election_path(election)
        end
      end
    end
  end
end
