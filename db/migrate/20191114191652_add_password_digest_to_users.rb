class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :Users, :password_digest, :string
  end
end
