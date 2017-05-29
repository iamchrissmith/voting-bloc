class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true
  enum role: [:user, :candidate, :admin]

  has_many :ballots, as: :candidate
  has_many :elections, through: :ballots, as: :candidate

  def full_name
    "#{first_name} #{last_name}"

  end
end
