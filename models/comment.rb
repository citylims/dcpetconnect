class Comment < ActiveRecord::Base
	# validates_presence_of :body, :user_id, presence: true
	belongs_to :user
	belongs_to :post
	
end