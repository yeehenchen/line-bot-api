class DeleteStatusToPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :statusMessage, :string
  end
end
