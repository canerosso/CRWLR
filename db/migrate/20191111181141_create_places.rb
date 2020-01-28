class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :business_id
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.float :latitude
      t.float :longitude
      t.float :stars
      t.integer :price_range
      t.string :categories

      t.timestamps
    end
  end
end
