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

  it "a candidate can view additional candidate profile info"
end
