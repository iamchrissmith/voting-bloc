class ChangeUserIdToCandidateIdOnBallots < ActiveRecord::Migration[5.1]
  def change
    rename_column :ballots, :user_id, :candidate_id
  end
end
