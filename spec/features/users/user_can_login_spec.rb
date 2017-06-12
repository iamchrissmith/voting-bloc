require 'rails_helper'

RSpec.describe "User logs in" do
  it "they can log in" do
    user = create(:user)

    visit login_path
    within("form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Login"
    end

    expect(current_path).to eq user_path(user)
    expect(page).to have_content("Successfully logged in!")
    expect(page).to have_content("Welcome, #{user.full_name}!")
    expect(page).to have_content("Logout")
  end

  context "when logged in and they try to visit the login page" do
    it "they are redirected to their user profile" do
      user = create(:user)

      visit login_path
      within("form") do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_on "Login"
      end

      expect(current_path).to eq user_path(user)

      visit login_path

      expect(current_path).to eq user_path(user)
      expect(page).to have_content("Welcome, #{user.full_name}!")
      expect(page).to have_content("Logout")
    end
  end


  context "they see error messages for incorrect logins" do
    it "no password" do
      user = create(:user)

      visit login_path
      within("form") do
        fill_in "Email", with: user.email
        fill_in "Password", with: ''
        click_on "Login"
      end

      expect(current_path).to eq login_path
      expect(page).to have_content('Invalid email/password combination')
    end

    it "incorrect password" do
      user = create(:user)

      visit login_path
      within("form") do
        fill_in "Email", with: user.email
        fill_in "Password", with: 'BadPass'
        click_on "Login"
      end

      expect(current_path).to eq login_path
      expect(page).to have_content('Invalid email/password combination')
    end

    it "no email" do
      user = create(:user)

      visit login_path
      within("form") do
        fill_in "Email", with: ''
        fill_in "Password", with: user.password
        click_on "Login"
      end

      expect(current_path).to eq login_path
      expect(page).to have_content('Invalid email/password combination')
    end

    it "no user" do
      visit login_path
      within("form") do
        fill_in "Email", with: 'made@up.com'
        fill_in "Password", with: 'awesome!'
        click_on "Login"
      end

      expect(current_path).to eq login_path
      expect(page).to have_content('Invalid email/password combination')
    end

  end
end
