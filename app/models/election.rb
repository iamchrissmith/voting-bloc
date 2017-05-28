class Election < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :topic, presence: true
  
  has_many :ballots
  has_many :users, through: :ballots

  def started?
    start_date <= Date.today
  end

  def ended?
    end_date <= Date.today
  end
end
