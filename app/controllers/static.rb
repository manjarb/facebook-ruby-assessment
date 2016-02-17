get '/' do
  #erb :"static/index"
  	if logged_in?
		redirect '/timeline'
	else
		erb :"users/signup"
	end
end

post '/signup' do
	user = User.new(params[:user])
	if user.save
		session["email"] = params[:user][:email]
		redirect '/timeline'
	else
		user.errors.full_messages
	end

	#user = User.create(params[:user])
end

get '/timeline' do
	
	if logged_in?
		# questions = Question.where(user_id: params[:id])
		# answers = Answer.where(user_id: params[:id])

		@posts = Post.all.order(id: :desc)

		erb :"users/timeline"
	else
		redirect "/"
	end
end

get '/logout' do
	session["email"] = nil

	redirect '/'
end

post '/login' do
	user = User.find_by(email: params[:email])
	if user
		if user.password == params[:password]
			session["email"] = params[:email]
			#{}"ss start"
			#erb :"questions/top_stories"
			redirect '/timeline'
		else
			#erb :"users/signup"
			redirect '/'
		end
	else
		redirect '/'
	end
	
end

post "/posts" do

	post = current_user.posts.create(content: params[:post_content])

	redirect "/timeline"

end

post "/comments" do

	comment = current_user.comments.create(content: params[:comment_content],post_id: params[:post_id])

	redirect "/timeline"

end

get "/post/delete/:post_id/:user_id" do
	
	if current_user_check?(User.find(params[:user_id]))
		post = Post.find_by(id: params[:post_id])
		post.destroy
		redirect "/timeline"
	else
		redirect "/timeline"
	end

end

get "/comment/delete/:comment_id/:user_id" do
	
	if current_user_check?(User.find(params[:user_id]))
		comment = Comment.find_by(id: params[:comment_id])
		comment.destroy
		redirect "/timeline"
	else
		redirect "/timeline"
	end

end

get "/like/post/:post_id" do

	if logged_in?

		like = current_user.likes.create(post_id: params[:post_id])		

		redirect '/timeline'
	else
		redirect '/timeline'
	end 

end

get "/unlike/post/:like_id/:user_id" do

	if current_user_check?(User.find(params[:user_id]))
		like = Like.find_by(id: params[:like_id])
		like.destroy
		redirect "/timeline"
	else
		redirect "/timeline"
	end

end

