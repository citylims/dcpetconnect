class Pet < ActiveRecord::Base
  validates :pet_name, :animal, :breed, presence: true 
  belongs_to :user
end