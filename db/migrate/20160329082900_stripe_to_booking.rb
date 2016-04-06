class StripeToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :stripeToken, :string
    add_column :bookings, :stripe_customer_id, :string
  end
end
