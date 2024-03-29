###
# ライブラリの読み込み
###
require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'
require 'sinatra/cookies'
require 'pg'

###
# Sinatraの設定
###
set :public_folder, 'public'
enable :sessions

def db
  host = 'localhost'
  user = 'yutaka' #自分のユーザー名を入れる
  password = ''
  dbname = 'myapp'

  # PostgreSQL クライアントのインスタンスを生成
  PG::connect(
  :host => host,
  :user => user,
  :password => password,
  :dbname => dbname)
end

###
# ルーティング
###

# /
get '/' do
  erb :index
end

# /hello?name=sabo
get '/hello' do
    # query string から取得
    # @name = params[:name]
    session[:name] =  params[:name]

    erb :hello
end

get '/users' do
  @users = db.exec_params("select * from users").to_a
  
  erb :users
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

get '/upload' do
  @images = Dir.glob("./public/images/*").map{|path| path.split('/').last }
  
  erb :upload
end

post '/upload' do
  @file_name = params[:img][:filename]
  FileUtils.mv(params[:img][:tempfile], "./public/images/#{@file_name}")

  # erb :uploaded
  redirect '/upload'
end