require_relative "../db/connection"


class Post < ActiveRecord::Base
	validates_presence_of :body, :user_id, presence: true
	belongs_to :user

end