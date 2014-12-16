require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
# require 'sinatra/reloader'
require 'pry'

# require 'sinatra/activerecord'
require_relative './models/user'
require_relative './models/pet'
require_relative './models/post'
require_relative './config/environments'

binding.pry


enable :sessions


#USER ROUTES

get '/' do
	@front_page_pet = Pet.pluck(:image)
	@selected_pet = @front_page_pet.sample
	pet = Pet.find_by(image: @selected_pet)
	owner = pet.user_id
	pet_owner = User.find(owner)
	@pet_hood = pet_owner.neighborhood
	@front_pet = pet.pet_name


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


get "/delete" do
	@delete_id = session[:user_id]
	@user = User.find_by(id: @delete_id)

	erb :delete
end


post "/delete_user" do 
	@user_id = params[:user_to_delete]
	@deletion = User.find(@user_id)
	@deletion.destroy
	redirect('/')
end


get "/session/logout" do
  session.clear
  redirect('/')
end



#PETS ROUTES

get '/pets' do

	@total_pets = Pet.all 
		

	erb :petlist
end


get '/pets/:pet_name' do
	@this_pet = params[:pet_name]
 	@pet = Pet.where(pet_name: @this_pet)

 	erb :petpage
end	


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
	redirect ('/users')
end


put "/update_pet/:pet_name" do 
	 current_user = session[:user_id]
	 user = User.find(current_user)
	 current_user_pets = user.pets
	 current_pets = current_user_pets.pluck(:pet_name)
	 update_pet_name = params[:pet_name]

		 if current_pets.include?(update_pet_name)
		update_pet_name = params[:pet_name]
		update_pet = Pet.find_by(pet_name: update_pet_name)
		new_image = params[:new_image]
		update_pet.image = new_image
		update_pet.save
		redirect('/pets')
		else
		redirect('/')
	end
end



#HOODS ROUTES

get '/hoods' do 
	@hoods = ["capitolhill", "clevelandwoodley", "glovergeorgetown", "mtpleasantcolumbiaheights", "dupontcircle", "shawbloomingdale", "tenleytown", "petworth" ,"takoma"]
	erb :hoods
end

get "/hoods/:neighborhood" do 
 
	@hoods=["capitolhill", "clevelandwoodley", "glovergeorgetown", "mtpleasantcolumbiaheights", "dupontcircle", "shawbloomingdale", "tenleytown", "petworth" ,"takoma"]
	@neighborhood = params[:neighborhood]

	 	if @hoods.include?(@neighborhood)
	# finding users who live in selected hood
	@neighborhood = params[:neighborhood]
	@neighborhood_users = User.where(neighborhood: @neighborhood)
	# finding pets who live in selected hood
	@neighborhood_users_ids = @neighborhood_users.pluck(:id)
	@neighborhood_pets = Pet.where(user_id: @neighborhood_users)
		else 
			redirect('/')
		end
	erb :neighborhood
end












