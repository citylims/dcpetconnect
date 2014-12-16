class CreatePosts < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  	  t.text :body, null: false
  	  t.text :image
  	  t.belongs_to :user
  	  t.timestamp
  	end
  end
end
