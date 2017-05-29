require 'rails_helper'

RSpec.describe "a user can see their profile" do
  it "a user can view their profile info" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(page).to have_content "Your Profile"
    expect(page).to have_content "Welcome, #{user.full_name}!"
    expect(page).to have_content "Your Voting History"
    expect(page).not_to have_content "Your Candidate Profile"
    expect(page).not_to have_content "Your Candidate History"
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

  it "a candidate can view additional candidate profile info" do
    candidate = create(:candidate)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

    visit user_path(candidate)

    expect(page).to have_content "Your Profile"
    expect(page).to have_content "Your Voting History"
    expect(page).to have_content "Your Candidate Profile"
    expect(page).to have_content "Your Candidate History"
    expect(page).to have_link "Edit Your Profile", href: edit_user_path(candidate)
  end

  it "a user can decide to become a candidate" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(page).to have_link "Become a Candidate", href: user_become_candidate_path(user)

    click_link "Become a Candidate"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "You have been made into a candidate.  Now you can run in elections."
    expect(page).to have_content "Your Candidate Profile"
  end

  it "an admin cannot become a candidate" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit user_path(admin)

    expect(page).not_to have_link "Become a Candidate", href: user_become_candidate_path(admin)
  end

  it "a candidate cannot become a candidate" do
    candidate = create(:candidate)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

    visit user_path(candidate)

    expect(page).not_to have_link "Become a Candidate", href: user_become_candidate_path(candidate)
  end
end
