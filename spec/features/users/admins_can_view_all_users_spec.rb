require 'rails_helper'

RSpec.describe "an admin can view all users" do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:candidate_1) { create(:candidate) }

  it "they can see a page with all users" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content "All Users"
    expect(page).to have_content user_1.full_name
    expect(page).to have_content user_2.full_name
    expect(page).to have_content candidate_1.full_name
    expect(page).to have_css(".btn-view", count: 4)
    expect(page).to have_content("user", count: 2)
    expect(page).to have_content("admin", count: 1)
    expect(page).to have_content("candidate", count: 1)
  end

  it "they can edit themselves" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content "All Users"
    expect(page).to have_css(".btn-edit", count: 1)
  end

  it "they can delete users but not themselves" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content "All Users"
    expect(page).to have_css(".btn-delete", count: 3)
  end

  context "if a regular user tries to visit the page" do
    it "they are sent to the a 404 page" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_users_path

      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end
end
