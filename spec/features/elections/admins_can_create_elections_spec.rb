require 'rails_helper'

RSpec.describe "an admin can create an election" do
  let!(:user_1) { create(:user) }
  let!(:candidate_1) { create(:candidate) }

  it "they can create an election" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit elections_path

    click_link "New Election"

    fill_in "Start date", with: "2017-01-01"
    fill_in "End date", with: "2017-06-30"
    fill_in "Topic", with: "Test Election"
    fill_in "Description", with: "Lorem Ipsum..."
    page.check full_name(candidate_1)

    expect(page).not_to have_content full_name(user_1)

    click_button "Create Election"

    expect(current_path).to eq elections_path
    expect(page).to have_content "Election created!"
  end

  context "when not an admin" do
    it "users cannot create elections" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit elections_path

      expect(page).not_to have_content "New Election"
    end

    it "candidates cannot create elections" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate_1)

      visit elections_path

      expect(page).not_to have_content "New Election"
    end

    context "when they directly visit the new page" do
      it "they are shown a 404 page" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit new_admin_election_path

        expect(page).to have_content "The page you were looking for doesn't exist (404) The page you were looking for doesn't exist."
      end
    end
  end
end
