

class Pet < ActiveRecord::Base
	validates_presence_of :pet_name, :animal, :breed, presence: true 
	belongs_to :user
end