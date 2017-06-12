class RenameUserColumnOnVotes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :votes, :user
    add_reference :votes, :voter, polymorphic: true
  end
end
