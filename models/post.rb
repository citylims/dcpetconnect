class Post < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :user
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
end