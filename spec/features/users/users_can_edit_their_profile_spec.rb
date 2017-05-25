require 'rails_helper'

RSpec.describe "a user can edit their profile" do
  it "a user can edit their profile info" do
    user = create(:user)
    orig_full = user.full_name
    orig_email = user.email

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    click_link "Edit Your Profile"

    fill_in "First Name", with: "New First"
    fill_in "Last Name", with: "New Last"
    fill_in "Email", with: "new_email@address.com"
    fill_in "Password", with: "321"

    click_button "Update Profile"
    user.reload

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "Your Profile"
    expect(page).to have_content "Welcome, New First New Last!"
    expect(page).to have_content "Profile updated."
    expect(page).not_to have_content orig_full
    expect(page).to have_content "new_email@address.com"
    expect(page).not_to have_content orig_email
    expect(page).to have_content "Logout"
    expect(page).to have_link "Edit Your Profile", href: edit_user_path(user)
  end
end
