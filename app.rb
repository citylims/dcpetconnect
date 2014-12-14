require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'
require 'active_record'

# require 'sinatra/activerecord'
# require_relative './models/user'
# require_relative './models/pet'
# require_relative './models/post'
# require_relative './config/environments'

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
	adapter: 'postgresql',
	host: 'localhost',
	database: 'dcpet_db'
)


class User < ActiveRecord::Base
	validates_presence_of :user_name, :email, :password, presence: true
	has_many :posts
	has_many :pets

end

class Pet < ActiveRecord::Base
	validates_presence_of :pet_name, :animal, :breed, presence: true 
	belongs_to :user
end

class Post < ActiveRecord::Base
	validates_presence_of :body, :user_id, presence: true
	belongs_to :user

end



get '/' do

	erb :index
end

post '/login' do 

end

get '/signup' do 

	erb :signup
end

post '/signup' do

end




binding.pry