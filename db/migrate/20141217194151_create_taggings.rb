class CreateTaggings < ActiveRecord::Migration
  def change
	create_table :taggings do |t|
	  	t.belongs_to :tag 
	  	t.belongs_to :post
  	end
  end
end

