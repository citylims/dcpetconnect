


class Post < ActiveRecord::Base
	# validates_presence_of :body, :user_id, presence: true
	belongs_to :user
	has_many :comments

end