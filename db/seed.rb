equire_relative 'app.rb'

 
# User.delete(User.all)
# Post.delete(Post.all)

 
# seed_posts = ["If you don't have anything nice to say come sit closer to me and let's talk about everyone",
# 	     	  "Glue is weird it's all like hey I want to stick these pieces of paper together wait I have an idea hand me that dead horse",
# 	     	  "I would love to start working out, but I'm beefing up for my \"before\" picture.",
# 	     	  "Sometimes I wonder if I'm a hoarder and then I think,\"No. But I should probably keep these used band-aids just in case.\"",
# 	     	  "Nice try, cheese graters, cheese is already great.",
# 	     	  "I bet people who see Jesus in a grilled cheese sandwich freak out over latte art."
# 	     	  ].shuffle
 
users = User.create([
	{user_name: "Austin", :email "austin@austin.com" :password "password", neighborhood: "Tenley"}

	])




num_users = users.length
num_posts = seed_posts.length
 
seed_posts.each_with_index do |post, i|
	user_index = i % num_users
	users[user_index].posts.create(body: post)
end