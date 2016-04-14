class AddCompleteToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :complete, :boolean, default: false
  end
end
