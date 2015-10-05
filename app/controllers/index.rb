get '/' do
  redirect 'index'
end

get '/index' do
  erb :index
end
