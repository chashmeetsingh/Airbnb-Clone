class AddProfileAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :phone_no, :integer
    add_column :users, :profile_image, :string
  end
end
