class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :gender
      t.string :pet_type
      t.string :size
      t.string :description
      t.string :image_url
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.timestamps null: false
    end
  end
end
