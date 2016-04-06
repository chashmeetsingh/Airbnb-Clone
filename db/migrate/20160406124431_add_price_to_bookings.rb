class AddPriceToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :price, :integer
    add_column :bookings, :paid, :boolean, default: false
    add_column :bookings, :accept, :boolean, default: false
  end
end
