# => *****HOMEPAGE / LOGIN*****

get '/' do
  redirect 'index'
end

get '/index' do
  if session[:user_id]
    redirect "/users/#{session[:user_id]}"
  else
    erb :index
  end
end

# => *****LOGIN*****
post '/index' do
  user = User.find_by(email: params[:email])    # => we need a unique identifier for the user!
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect "/users/#{session[:user_id]}"
  else
    @errors = {login_error: "user name or password incorrect, try again"}
    redirect '/index'
  end
end

# => *****LOGOUT*****
post '/users/:uid' do
  session[:user_id] = nil
  redirect '/index'
end

# => *****SIGNUP*****
get '/new' do
  erb :new
end

post '/new' do
  @user = User.create(email: params[:email], password: params[:password])
  session[:user_id] = @user.id
  redirect "/users/#{session[:user_id]}"
end

# => *****PROFILE*****
get "/users/:uid" do
  @items = Item.all
  if session[:user_id].to_s == params[:uid]
    erb :profile
  else
    redirect '/index'
  end
end

# => *****ADD/MONITOR ITEM*****
post "/users/:uid" do
  @items = Item.all
  if session[:user_id].to_s == params[:uid]
    erb :profile
  else
    redirect '/index'
  end
end
