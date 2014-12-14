require 'sinatra'
require 'sinatra/reloader'
require 'pry'


# require 'sinatra/activerecord'
require_relative './models/user.rb'
require_relative './models/pet.rb'
require_relative './models/post.rb'
# require_relative './config/environments'

# binding.pry

enable :sessions



get '/' do

	erb :index
end

post '/login' do 
	user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect('/:id')
  else
    @errors << "Invalid email or password. Try again!"
  end
end

get '/users' do
	@users = User.all
	
	erb :users
end

get 'users/:user_name' do 
	@username = params[:user_name]
	# user_id = User.find_by(user_name: @username).id
	erb :profile
end



get '/signup' do 

	erb :signup
end

post '/signup' do
	@user_name = params[:username]
	@email = params[:email]
	# @password = params[:password]
	@password = BCrypt::Password.create(params[:password])
	@neighborhood = params[:neighborhood]
  User.create(user_name: @user_name, email: @email, password_digest: @password, neighborhood: @neighborhood)
  redirect('/')

end

get "/:neighborhood" do 
	@neighborhood = params[:neighborhood]


	erb :neighborhood
end





