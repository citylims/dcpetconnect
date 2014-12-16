class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  	  t.text :user_name, null: false
  	  t.text :email, null: false
  	  t.text :password_digest, null: false
  	  t.text :neighborhood, null: false
  	  t.timestamp
  	end
  end
end

