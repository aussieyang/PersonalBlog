
require 'sinatra'
require 'pg'

require './db_config'
require './models/user'
require './models/post'

configure :development do |c|
  require 'sinatra/reloader'
  require 'pry'
end

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    if current_user
          return true
        else
          return false
        end
  end

end

#display index
get '/' do
  @users = User.all

  @posts = Post.all
  erb :index
end

#display login
get '/session/new' do
  erb :login
end

#display new post
get '/posts/new' do
  erb :newpost
end

#display single post
get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :show
end

#display new user
get '/users/new' do
  erb :newuser
end

#diplay users
get '/users' do
  @users = User.all
  erb :users
end

#display single user
get '/users/:id' do
  @user = User.find(params[:id])
  erb :showuser
end

#display update post form
get '/posts/:id/edit' do
  @users = User.all
  @post = Post.find(params[:id])

  erb :editpost
end


#display update user form
get '/users/:id/edit' do
  @user = User.find(params[:id])
  @posts = Post.all

  erb :edituser
end

#store information from newpost
post '/posts' do
    @post = Post.new
    @post.heading = params[:heading]
    @post.post = params[:post]
    @post.image = params[:image_url]
    @post.topic = params[:topic]
    @post.user_id = current_user.id   #mapping user_id to current user id


    if @post.save
      redirect to '/'
    else
      erb :newpost
    end
end

#store information from newuser
post '/users' do
    @user = User.new
    @user.email = params[:email]
    @user.password = params[:password]
    @user.name = params[:name]
    @user.portrait = params[:portrait]
    @user.about = params[:about]
    @user.git = params[:git]

    if @user.save
      redirect to '/session/new'
    else
      erb :newuser
    end
end


# patch edits from editpost.erb to DB
patch '/posts/:id' do
  post = Post.find(params[:id])

  post.heading = params[:heading]
  post.topic = params[:topic]
  post.post = params[:post]
  post.image = params[:image_url]
  post.summary = params[:summary]

  post.save

  redirect to "/posts/#{ params[:id] }"
end


# patch edits from edituser.erb to DB
patch '/users/:id' do
  user = User.find(params[:id])

    user.email = params[:email]
    user.password = params[:password]
    user.name = params[:name]
    user.portrait = params[:portrait]
    user.about = params[:about]
    user.git = params[:git]

  user.save

  redirect to "/users/#{ params[:id] }"
end


# delete post
delete '/posts/:id' do

  post = Post.find(params[:id])
  post.destroy
  redirect to "/"
end

# delete user
delete '/users/:id' do
  user = User.find(params[:id])
  user.destroy && session.destroy
  redirect to "/"
end



#login - send info to check against DB
post '/session' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/'
  else
    erb :login
  end
end

# logout
delete '/session' do
  session[:user_id] = nil
  redirect to '/session/new'
end
