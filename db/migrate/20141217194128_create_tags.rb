class CreateTags < ActiveRecord::Migration
  def change
  	create_table :tags do |t|
  	  t.text :body
  	end
  end
end
