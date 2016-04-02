class ChangeLimitPhoneNo < ActiveRecord::Migration
  def change
    change_column :users, :phone_no, :integer
  end
end
