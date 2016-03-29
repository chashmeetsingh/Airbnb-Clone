class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :cust_id
      t.integer :provider_id
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
