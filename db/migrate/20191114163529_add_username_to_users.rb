class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :Users, :username, :string
  end
end
