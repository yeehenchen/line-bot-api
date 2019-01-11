class AddStatusAndWinnerToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :status, :boolean
    add_column :games, :winner, :string
  end
end
