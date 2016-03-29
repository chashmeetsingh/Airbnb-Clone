class AddPerDayCostToUser < ActiveRecord::Migration
  def change
    add_column :users, :per_day_price, :integer, default: 5
  end
end
