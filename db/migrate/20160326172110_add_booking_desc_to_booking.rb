class AddBookingDescToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :description, :string
  end
end
