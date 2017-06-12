require 'rails_helper'

RSpec.describe "an admin can delete a user" do
  it "the user is deleted" do
    admin = create(:admin)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    click_on "Delete"

    expect(page).to have_content "All Users"
    expect(page).to have_content "#{user.full_name} was successfully deleted."
    expect(page).not_to have_content user.email
    expect(page).to have_content admin.email
  end

  it "the candidate is deleted" do
    admin = create(:admin)
    candidate = create(:candidate)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    click_on "Delete"

    expect(page).to have_content "All Users"
    expect(page).to have_content "#{full_name(candidate)} was successfully deleted."
    expect(page).not_to have_content candidate.email
    expect(page).to have_content admin.email
  end
end
