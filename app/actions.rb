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

  def error_handling
    @errors = session[:errors] if session[:errors]
    session[:errors] = nil
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end

before do
  current_user
  error_handling
end

get '/' do
  erb :index
end

post '/login' do
  session[:attempt] = params[:email]
  user = User.find_by_email(params[:email])
  if user && BCrypt::Password.new(user.password) == params[:password]
    session[:user_id] = user.id
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
  pass = BCrypt::Password.create(params[:password])
  @user = User.new(
    email: params[:email],
    password: pass
    )
  if @user.save
    redirect '/tracks'
  else
    redirect '/signup'
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
    redirect 'tracks'
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
    redirect '/tracks'
  end
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  if @track
    erb :'tracks/show'
  else
    redirect '/tracks'
  end
end

post '/review/:id' do
  # byebug
  @review = Review.new(
    content: params[:content],
    user_id: current_user.id,
    track_id: params[:id],
    rating: params[:rating]
    )
  if @review.save
    redirect "/tracks/#{@review.track_id}"
  else
    redirect "/tracks/#{@review.track_id}"
  end
end

delete '/review/:id' do
  review = Review.find(params[:id])
  review.destroy
  redirect "/tracks/#{review.track_id}"
end