# Homepage (Root path)
helpers do
  def generate_title
    title = ""
    3.times { |adj| title << RandomWord.adjs.next.capitalize << ' ' }
    title << RandomWord.nouns.next.capitalize
  end

  def generate_author
    RandomWord.nouns.next.capitalize
  end

  SONG = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
end


get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks' do
  @track = Track.new(
    song_title: generate_title,
    author: generate_author,
    url: SONG
    )
  erb :'tracks/new'
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end