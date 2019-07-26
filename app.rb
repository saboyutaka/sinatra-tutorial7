require 'sinatra'
require 'sinatra/reloader'

set :public_folder, 'public'

# /
get '/' do
  'Hello World!!!!!'
end

# /hello?name=sabo
get '/hello' do
    # query string から取得
    @name = params[:name]
    
    erb :hello
end

# /user/saboyutaka
get '/user/:user_name' do
    # 可変URLからuser_nameを取得
    user_name = params[:user_name]
    "<h1>User: #{user_name}!</h1>"
end

# /time
get '/time' do
    Time.now.to_s
end
        
get '/form' do
  erb :form
end

post '/form_output' do
  # POSTのリクエストボディから値を取得
  @name = params[:name]
  @email = params[:email]
  @content = params[:content]

  # ファイルに保存する
  File.open("form.txt", mode = "a"){|f|
    f.write("#{@name},#{@email},#{@content}\n")
  }

  erb :form_output
end