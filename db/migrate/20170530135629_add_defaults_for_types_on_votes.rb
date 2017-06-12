class AddDefaultsForTypesOnVotes < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:votes, :voter_type, "User")
    change_column_default(:votes, :recipient_type, "User")
  end
end
