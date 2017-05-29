class Ballot < ApplicationRecord
  belongs_to :election
  belongs_to :candidate, polymorphic: true
end
