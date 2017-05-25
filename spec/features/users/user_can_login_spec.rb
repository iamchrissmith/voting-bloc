require 'rails_helper'

RSpec.describe "User logs in" do
  it "they can log in" do
    user = create(:user)

    visit login_path
    within("form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_on "Login"
    end

    expect(current_path).to eq user_path(user)
    expect(page).to have_content("Successfully logged in!")
    expect(page).to have_content("Welcome, #{user.full_name}!")
    expect(page).to have_content("Logout")
  end
end
