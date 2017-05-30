class Vote < ApplicationRecord
  belongs_to :election
  belongs_to :voter, polymorphic: true
  belongs_to :recipient, polymorphic: true
end
