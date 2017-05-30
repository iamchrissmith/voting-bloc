class AddForeignKeyToVotesForElections < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :votes, :elections, column: :election_id
  end
end
