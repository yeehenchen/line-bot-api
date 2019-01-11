class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :winNum
      t.string :roomId

      t.timestamps
    end
  end
end
