class CreateCrawlPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :crawl_places do |t|
      t.integer :crawl_id
      t.integer :place_id
      t.float :duration

      t.timestamps
    end
  end
end
