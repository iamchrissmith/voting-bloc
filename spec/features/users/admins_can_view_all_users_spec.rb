require 'rails_helper'

RSpec.describe "an admin can view all users" do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:user_3) { create(:user) }

  it "they can see a page with all users" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content "All Users"
    expect(page).to have_content user_1.full_name
    expect(page).to have_content user_2.full_name
    expect(page).to have_content user_3.full_name
    expect(page).to have_css(".btn-view", count: 4)
    expect(page).to have_css(".btn-edit", count: 4)
    expect(page).to have_content("user", count: 3)
    expect(page).to have_content("admin", count: 1)
  end

  it "they can delete users but not themselves" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content "All Users"
    expect(page).to have_css(".btn-delete", count: 3)
  end
end
