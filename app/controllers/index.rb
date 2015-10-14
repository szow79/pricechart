
  get '/testpage' do
    @title = 'Ethnic Composition'
    @data = {'Hoklo' => 70, 'Hakka' => 15, 'mainlander' => 13, 'indigenous' => 2}
    @source = 'http://en.wikipedia.org/wiki/Demographics_of_Taiwan'
    erb :testpage
  end


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
get '/users/:uid' do
  @items = Item.where(user_id: session[:user_id])
  @records = Record.all
  if session[:user_id].to_s == params[:uid]
    erb :profile
  else
    redirect '/index'
  end
end

# => *****ADD/MONITOR ITEM*****
post '/users/:uid/add' do
  user = User.find(session[:user_id])
  properties = scrape(params[:url])
  item = user.add_item(properties)
  redirect '/users/:uid'
end

# => *****REMOVE ITEM*****
post '/users/:uid/:iid' do
  target_item_id = params[:iid]
  Item.find(target_item_id).destroy
  Record.where(item_id: target_item_id).map(&:destroy)
  redirect '/users/:uid'
end

# => *****ADMIN/SYSTEM RECORD PRICES*****
post '/record' do
  system_record
  redirect '/users/:uid'
end

