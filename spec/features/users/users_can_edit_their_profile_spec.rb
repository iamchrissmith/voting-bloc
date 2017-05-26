require 'rails_helper'

RSpec.describe "a user can edit their profile" do
  it "a user can edit their profile info" do
    user = create(:user)
    orig_full = user.full_name
    orig_email = user.email

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    click_link "Edit Your Profile"

    expect(page).not_to have_field "user[profile]"

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

  context "when a candidate edits their profile" do
    it "they can add candidate profile text" do
      candidate = create(:candidate)
      orig_full = candidate.full_name
      orig_email = candidate.email

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

      visit user_path(candidate)

      click_link "Edit Your Profile"

      expect(page).to have_field "user[profile]"

      fill_in "First Name", with: "New First"
      fill_in "Last Name", with: "New Last"
      fill_in "Email", with: "new_email@address.com"
      fill_in "Password", with: "321"
      fill_in "Short Bio", with: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras faucibus rutrum urna, vel tincidunt elit lacinia eget. Donec magna lectus, vulputate eget varius cursus, condimentum nec erat. Duis facilisis leo nibh, at fermentum purus. Donec dignissim neque id velit scelerisque id rhoncus est malesuada. Pellentesque elit risus, faucibus vel vulputate eget, malesuada eu tortor. Donec vulputate pretium odio, id congue velit consectetur in. Fusce lobortis ultrices elementum. Suspendisse potenti. Suspendisse felis lectus, lobortis eget scelerisque eget, ultricies non enim. Praesent commodo lectus a mauris posuere ac condimentum ipsum laoreet. Donec quis ipsum turpis, eu rhoncus augue. Quisque mollis, sem sit amet adipiscing sagittis, sapien odio fringilla enim, a tempus augue lectus in enim. Donec sed diam nulla, sed mattis metus. Etiam placerat dictum quam a sagittis. Vestibulum interdum tellus eget nunc consequat in tristique turpis imperdiet. Sed dapibus, nulla sed sollicitudin pulvinar, purus est dignissim sapien, sagittis egestas risus est luctus nulla."

      click_button "Update Profile"
      candidate.reload

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(candidate)

      expect(current_path).to eq user_path(candidate)
      expect(page).to have_content "Your Profile"
      expect(page).to have_content "Welcome, New First New Last!"
      expect(page).to have_content "Profile updated."
      expect(page).not_to have_content orig_full
      expect(page).to have_content "new_email@address.com"
      expect(page).not_to have_content orig_email
      expect(page).to have_content "Logout"
      expect(page).to have_link "Edit Your Profile", href: edit_user_path(candidate)
    end
  end
end
