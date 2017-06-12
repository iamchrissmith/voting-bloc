class CreateElections < ActiveRecord::Migration[5.1]
  def change
    create_table :elections do |t|
      t.date :start_date
      t.date :end_date
      t.string :topic
      t.text :description
    end
  end
end
