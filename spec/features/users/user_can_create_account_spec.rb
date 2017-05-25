require 'rails_helper'

RSpec.describe "a user can be created" do
  it "they can create their own user" do
    visit new_user_path

    fill_in "First Name", with: "Test"
    fill_in "Last Name", with: "Test"
    fill_in "Email", with: "test_new@emailtest.com"
    fill_in "Password", with: "123"

    click_button "Create Account"

    expect(page).to have_content("Welcome, Test Test!")
    expect(page).to have_content("Account created!")
    expect(page).to have_link "Logout", logout_path
  end
end
