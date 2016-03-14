class RemoveAgeFromDogAddYearMonth < ActiveRecord::Migration
  def change
    remove_column :dogs, :age
    add_column :dogs, :year, :integer
    add_column :dogs, :month , :integer
  end
end
