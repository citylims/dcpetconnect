require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'active_record'

# require 'sinatra/activerecord'
require_relative './models/user'
require_relative './models/pet'
require_relative './models/post'
require_relative './config/environments'

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
	adapter: 'postgresql',
	host: 'localhost',
	database: 'dcpet_db'
)


class < User ActiveRecord::Base

end

class < Pet ActiveRecord::Base

end

class < Post ActiveRecord::Base

end