require 'rails_helper'

RSpec.describe "a user can see their profile" do
  it "a user can view their profile info" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(page).to have_content "Your Profile"
    expect(page).to have_content "Welcome, #{user.full_name}!"
    expect(page).to have_content "Logout"
    expect(page).to have_link "Edit Your Profile", href: edit_user_path(user)
  end

  context "when trying to view another user's profile" do
    it "shows them their own profile" do
      this_user = create(:user)
      other_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(this_user)

      visit user_path(other_user)

      expect(page).to have_content "Your Profile"
      expect(page).to have_content "Welcome, #{this_user.full_name}!"
    end

    it "redirects admins" do
      this_user = create(:admin)
      other_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(this_user)

      visit user_path(other_user)

      expect(page).to have_content "Your Profile"
      expect(page).to have_content "Welcome, #{this_user.full_name}!"
    end
  end

  it "a candidate can view additional candidate profile info"
end
