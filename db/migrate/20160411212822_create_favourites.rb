class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :cust_id
      t.integer :provider_id

      t.timestamps null: false
    end
  end
end
