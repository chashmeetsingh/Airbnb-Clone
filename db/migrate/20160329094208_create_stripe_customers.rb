class CreateStripeCustomers < ActiveRecord::Migration
  def change
    create_table :stripe_customers do |t|
      t.integer :user_id
      t.string :stripe_user_id

      t.timestamps null: false
    end
  end
end
