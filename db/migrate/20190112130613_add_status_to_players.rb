class AddStatusToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :statusMessage, :string
  end
end
