require 'sinatra'
require 'sinatra/activerecord'

# require 'sinatra/reloader'
# require 'pry'

# require 'sinatra/activerecord'
require_relative './models/user'
require_relative './models/pet'
require_relative './models/post'
require_relative './config/environments'

# binding.pry

enable :sessions



get '/' do
	@front_page_pet = Pet.pluck(:image)

	erb :index
end

post '/login' do 
	user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect('/users')
  else
    @errors << "Invalid email or password. Try again!"
  end
end

get '/users' do
	@all_users = User.all
	
	erb :users
end

get '/users/:user_name' do 
	@username = params[:user_name]		
	@current = User.find_by(user_name: @username)
	@current_id = @current.id
	@current_pets = Pet.where(user_id: @current_id)

	# @name = @current.user_name
	erb :profile
end

# get '/:user_name' do 
# 	@username = params[:user_name]
# 	# user = User.find_by(user_name: @username)
# 	erb :profile
# end

get "/addpet" do

	erb :addpet
end

post "/addpet" do
	@pet_name = params[:pet_name]
	@animal_type = params[:animal]
	@breed = params[:breed]
	@image = params[:image]
	@user_id = session[:user_id]
	Pet.create(pet_name: @pet_name, animal: @animal_type, breed: @breed, image: @image, user_id: @user_id)
	redirect ('/users/')
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

get '/hoods' do 
	@hoods = ["Capitol Hill", "Cleveland/Woodley Park", "Gloverpark/Georgetown", "Mt. Pleasant/Columbia Heights", "Dupont Circle/Downtown DC", "Tacoma Park", "Shaw/Bloomingdale", "Tenley Town/Friendship Heights", "Petworth"]
	erb :hoods
end

get "/hoods/:neighborhood" do 
	@neighborhood = params[:neighborhood]
	@neighborhood_users = User.where(neighborhood: @neighborhood)



	erb :neighborhood
end


get "/session/logout" do
  session.clear
  redirect('/')
end


