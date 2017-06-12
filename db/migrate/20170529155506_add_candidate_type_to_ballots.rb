class AddCandidateTypeToBallots < ActiveRecord::Migration[5.1]
  def change
    add_column :ballots, :candidate_type, :string
  end
end
