class ChangeLimitPhoneNo < ActiveRecord::Migration
  def change
    change_column :users, :phone_no, :integer, limit: 10
  end
end
