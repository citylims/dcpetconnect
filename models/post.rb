


class Post < ActiveRecord::Base
	# validates_presence_of :body, :user_id, presence: true
	belongs_to :user
	has_many :comments
	has_many :taggings
  	has_many :tags, through: :taggings

end