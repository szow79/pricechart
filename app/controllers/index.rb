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
  @items = Item.all
  if session[:user_id].to_s == params[:uid]
    erb :profile
  else
    redirect '/index'
  end
end

# => *****ADD/MONITOR ITEM*****
post '/users/:uid/add' do
  user = User.find(session[:user_id])
  product_url = params[:url]
  properties = scrape(product_url)
  item = user.add_item(properties, product_url)
  item.records.create(price: properties[:price].scan(/\d/).join.to_i)
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

