class Election < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :topic, presence: true

  has_many :ballots
  has_many :candidates, through: :ballots, source: :candidate, source_type: "User"

  has_one :vote
  has_many :recipients, through: :vote, source: :recipient, source_type: "User"
  has_many :voters, through: :vote, source: :voter, source_type: "User"

  def started?
    start_date <= Date.today
  end

  def ended?
    end_date <= Date.today
  end

  def can_run? (user)
    user.candidate? && !candidates.include?(user) && !started? && !ended?
  end

  def can_be_deleted?(user)
    not_started_and_admin?(user)
  end

  def can_be_edited?(user)
    not_started_and_admin?(user)
  end

  private

   def not_started_and_admin?(user)
     !started? && user.admin?
   end
end
