# Homepage (Root path)
enable :sessions

helpers do
  SONG = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  def generate_title
    title = ""
    3.times { |adj| title << RandomWord.adjs.next.capitalize << ' ' }
    title << RandomWord.nouns.next.capitalize
  end

  def generate_author
    RandomWord.nouns.next.capitalize
  end
end

get '/' do
  erb :index
end

post '/login' do
  users = User.where(email: params[:email]).where(password: params[:password])

  unless users.empty?
    session[:user_id] = users.first.id
    redirect '/tracks'
  else
    @message = 'Invalid email and password'
    redirect '/tracks'
  end
end

post '/logout' do
  session.clear
  session[:user_id] = nil
  redirect '/tracks'
end

get '/signup' do
  @user = User.new
  erb :'signup'
end

post '/signup' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
    )
  if @user.save
    redirect '/tracks'
  else
    erb :'signup'
  end
end

get '/tracks' do
  @tracks = Track.ordered_list
  erb :'tracks/index'
end

post '/tracks' do
  @track = Track.new(
    song_title: generate_title,
    author: generate_author,
    url: SONG,
    user_id: session[:user_id]
    )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/index'
  end
end

post '/upvote' do
  @vote = Vote.new(
    user_id: session[:user_id],
    track_id: params[:track_id]
    )
  if @vote.save
    redirect '/tracks'
  else
    erb :'tracks/index'
  end
end