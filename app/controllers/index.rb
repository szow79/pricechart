get '/' do
  redirect 'index'
end

# homepage / login page
get '/index' do
  erb :index
end

# new user signup page
get '/users/new' do
  erb :new
end

# logging in from /index
post '/index' do
  p params
  user = User.find_by(email: params[:email])    # we need a unique identifier for the user!
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect "/users/#{session[:user_id]}"
  else
    @errors = {login_error: "user name or password incorrect, try again"}
    redirect '/index'
  end
end

# creating user from /users/new
post '/users/new' do
  @user = User.create(email: params[:email], password: params[:password])
  session[:user_id] = @user.id
  redirect "/users/#{session[:user_id]}"
end

get "/users/:uid" do
  if session[:user_id].to_s == params[:uid]
    erb :profile
  else
    redirect '/index'
  end
end

post '/users/:uid' do
  session[:user_id] = nil
  redirect '/index'
end
