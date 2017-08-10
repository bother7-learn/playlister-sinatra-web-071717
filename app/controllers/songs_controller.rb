class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash
  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :"songs/new"
  end

  get '/songs/:slug/edit' do
    @artists = Artist.all
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  get '/songs/:slug' do
    # binding.pry
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    @song.update(params[:song])
    if params[:artist] != ""
      @artist = Artist.find_or_create_by(name: params[:artist])
      @song.artist = @artist
      @song.save
      @artist.save
    end
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

  post '/songs' do
    @song = Song.create(params[:song])
    if params[:artist] != ""
      @artist = Artist.find_or_create_by(name: params[:artist])
      @artist.songs << @song
      @artist.save
    end
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end






end
