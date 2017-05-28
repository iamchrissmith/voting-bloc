require 'rails_helper'

RSpec.describe Election, type: :model do
  describe "validations" do
    context "with invalid attributes" do
      it "is invalid without a start_date" do
        election = build(:election, start_date: '')
        expect(election).to be_invalid
      end

      it "is invalid without an end_date"do
        election = build(:election, end_date: '')
        expect(election).to be_invalid
      end

      it "is invalid without a topic"do
        election = build(:election, topic: '')
        expect(election).to be_invalid
      end
    end
    context "with valid attributes" do
      it "election is valid with all required attributes" do
        election = build(:election)
        expect(election).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many users" do
      election = create(:election)
      expect(election).to respond_to(:users)
    end
  end

  describe ".started?" do
    it "returns true if start_date is before now" do
      election = create(:election)
      Timecop.freeze(election.start_date + 1) do
        expect(election.started?).to be true
      end
    end

    it "returns false if start_date is after now" do
      election = create(:election)

      Timecop.freeze(election.start_date - 1) do
        expect(election.started?).to be false
      end
    end
  end

  describe ".ended?" do
    it "returns true if end_date is before now" do
      election = create(:election)
      Timecop.freeze(election.end_date + 1) do
        expect(election.ended?).to be true
      end
    end

    it "returns false if end_date is after now" do
      election = create(:election)

      Timecop.freeze(election.end_date - 1) do
        expect(election.ended?).to be false
      end
    end
  end
end
