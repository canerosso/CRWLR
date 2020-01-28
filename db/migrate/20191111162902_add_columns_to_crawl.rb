class AddColumnsToCrawl < ActiveRecord::Migration[6.0]
  def change
    add_column :crawls, :name, :string
    add_column :crawls, :location, :string
    add_column :crawls, :duration, :integer
    add_column :crawls, :date, :date
  end
end
