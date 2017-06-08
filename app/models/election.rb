class Election < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :topic, presence: true

  has_many :ballots
  has_many :candidates, through: :ballots, source: :candidate, source_type: "User"

  has_many :votes
  has_many :recipients, through: :votes, source: :recipient, source_type: "User"
  has_many :voters, through: :votes, source: :voter, source_type: "User"

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

  def vote_status(user)
    return "not_started" unless started?
    return "closed" if ended?
    return "result" if user.has_voted?(self)
    "vote"
  end

  def winner_with_votes
    winner  = results.take(1)
  end

  def results
    results = votes.joins('INNER JOIN users on users.id = votes.recipient_id')
                   .group("(users.first_name || ' ' || users.last_name)")
                   .order('count_all DESC').count
  end

  def self.upcoming_elections
    Election.where('start_date > ?', Date.today)
  end

  def self.past_elections
    Election.where('end_date < ?', Date.today)
  end

  def self.active_elections
    Election.where('start_date < ? AND end_date > ?', Date.today, Date.today)
  end

  private

   def not_started_and_admin?(user)
     !started? && user.admin?
   end
end
