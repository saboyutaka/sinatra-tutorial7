require 'sinatra'
require 'sinatra/reloader'

get '/' do
  'Hello World!!!!!'
end

get '/hello' do
    # query string から取得
    name = params[:name]
    "<h1>Hello #{name}!</h1>"
end

get '/user/:user_name' do
    # 可変URLからuser_nameを取得
    user_name = params[:user_name]
    "<h1>User: #{user_name}!</h1>"
end

get '/time' do
    Time.now.to_s
end
  