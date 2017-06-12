class ChangeCandidatesToRecipientsOnVotes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :votes, :candidate
    add_reference :votes, :recipient, polymorphic: true
  end
end
