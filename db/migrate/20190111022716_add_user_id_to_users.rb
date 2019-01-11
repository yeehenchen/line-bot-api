class AddUserIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :userId, :string
    add_column :players, :displayName, :string
    add_column :players, :pictureUrl, :string
    remove_column :players, :name, :string
    remove_column :players, :avatarurl, :string
  end
end
