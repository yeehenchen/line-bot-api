class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :avatarurl
      t.integer :balance

      t.timestamps
    end
  end
end
