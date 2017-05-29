class Election < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :topic, presence: true

  has_many :ballots
  has_many :candidates, through: :ballots, source: :candidate, source_type: "User"

  def started?
    start_date <= Date.today
  end

  def ended?
    end_date <= Date.today
  end

  def can_run? (user)
    user.candidate?
  end
end
