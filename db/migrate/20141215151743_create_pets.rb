class CreatePets < ActiveRecord::Migration
  def change
  	create_table :pets do |t|
  	  t.text :pet_name, null: false
  	  t.text :animal, null: false
  	  t.text :breed, null: false
  	  t.image :image
  	  t.belongs_to :user
  	end
  end
end


