class CreateCrawls < ActiveRecord::Migration[6.0]
  def change
    create_table :crawls do |t|
      t.integer :host_id

      t.timestamps
    end
  end
end
