class ChangePhoneNoType < ActiveRecord::Migration
  def change
    change_column :users, :phone_no, :string
  end
end
