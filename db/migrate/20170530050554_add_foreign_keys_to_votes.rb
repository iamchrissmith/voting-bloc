class AddForeignKeysToVotes < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :votes, :users, column: :voter_id
    add_foreign_key :votes, :users, column: :recipient_id
  end
end
