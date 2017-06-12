class RemoveElectionReferenceFromVotes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :votes, :election
    add_column :votes, :election_id, :integer
  end
end
