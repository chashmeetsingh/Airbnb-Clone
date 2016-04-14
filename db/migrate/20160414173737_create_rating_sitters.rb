class CreateRatingSitters < ActiveRecord::Migration
  def change
    create_table :rating_sitters do |t|
      t.string :comment
      t.integer :provider_id
      t.integer :cust_id
      t.string :rating
      t.integer :booking_id
      t.timestamps null: false
    end
  end
end
