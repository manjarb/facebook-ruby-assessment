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
		redirect '/top_stories'
	else
		user.errors.full_messages
	end

	#user = User.create(params[:user])
end

get '/timeline' do
	
	if logged_in?
		# questions = Question.where(user_id: params[:id])
		# answers = Answer.where(user_id: params[:id])

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



