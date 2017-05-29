require 'rails_helper'

RSpec.describe "a user can view an election" do
  it "they can see election details" do
    user = create(:user)
    election = create(:election)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit elections_path

    click_link "View"

    expect(current_path).to eq election_path(election)
    expect(page).to have_content election.topic
    expect(page).to have_link "All Elections", href: elections_path
  end
end
