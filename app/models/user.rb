class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true
  enum role: [:user, :candidate, :admin]

  has_many :ballots, as: :candidate
  has_many :elections, through: :ballots, as: :candidate

  has_many :votes, as: :recipient
  has_many :elections, through: :votes, as: :recipient

  has_many :votes, as: :voter
  has_many :elections, through: :votes, as: :voter

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_voted?(election)
    votes.pluck(:election_id).include?(election.id)
  end

  def voted_for(election)
    votes.where(election_id:election.id).first.recipient.full_name
  end
end
