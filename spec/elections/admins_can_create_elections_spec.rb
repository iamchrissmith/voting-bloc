require 'rails_helper'

RSpec.describe "an admin can create an election" do
  let!(:user_1) { create(:user) }
  let!(:candidate_1) { create(:candidate) }

  it "they can create an election" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit elections_path

    click_link "New Election"

    fill_in "Start Date", with: "01/01/17"
    fill_in "End Date", with: "06/30/17"
    fill_in "Topic", with: "Test Election"
    page.check candidate_1.full_name

    expect(page).not_to have_content user_1.full_name

    click_button "Create Election"

    expect(current_path).to eq elections_path
    expect(page).to have_content "Election create!"
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
  end
end
