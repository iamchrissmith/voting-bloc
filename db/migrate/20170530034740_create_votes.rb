class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :election, foreign_key: true
      t.references :candidate, polymorphic: true
    end
  end
end
