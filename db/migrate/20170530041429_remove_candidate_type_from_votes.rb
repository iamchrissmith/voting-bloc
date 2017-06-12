class RemoveCandidateTypeFromVotes < ActiveRecord::Migration[5.1]
  def change
    remove_column :votes, :candidate_type
  end
end
