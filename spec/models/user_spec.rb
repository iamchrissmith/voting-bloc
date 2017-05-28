require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    context "with invalid attributes" do
      it "is invalid without a first name" do
        user = build(:user, first_name: '')
        expect(user).to be_invalid
      end

      it "is invalid without a last name" do
        user = build(:user, last_name: '')
        expect(user).to be_invalid
      end

      it "is invalid without an email" do
        user = build(:user, email: '')
        expect(user).to be_invalid
      end

      it "is invalid without a password" do
        user = build(:user, password: '')
        expect(user).to be_invalid
      end
    end

    context "with valid attributes" do
      it "user is valid with all required attributes" do
        user = build(:user)
        expect(user).to be_valid
      end
    end
  end

  describe "user roles" do
    it "defaults new user to user" do
      user = create(:user)

      expect(user.role).to eq 'user'
      expect(user).not_to be_admin
      expect(user).not_to be_candidate
      expect(user).to be_user
    end

    it "creates a user as a candidate" do
      candidate = create(:candidate)

      expect(candidate.role).to eq 'candidate'
      expect(candidate).not_to be_user
      expect(candidate).not_to be_admin
      expect(candidate).to be_candidate
      expect(candidate.profile).not_to be_nil
    end

    it "creates a user as an admin" do
      admin = create(:admin)

      expect(admin.role).to eq 'admin'
      expect(admin).not_to be_user
      expect(admin).not_to be_candidate
      expect(admin).to be_admin
    end
  end

  describe ".full_name" do
    it "returns the first and last name" do
      user = create(:user)

      expect(user.full_name).to eq "#{user.first_name} #{user.last_name}"
    end
  end
end
