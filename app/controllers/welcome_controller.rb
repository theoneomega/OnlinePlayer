class WelcomeController < ApplicationController
  before_action :set_song, only: [:play, :audio_download, :download]
  def index
    @songs = Song.all

  end
  def play
    @song.played =@song.played+1
    @song.save
    render json: {"id"=> @song.id, played: @song.played}, :callback => params[:callback]
  end
  def audio_download
    @song.downloaded_times+=1
    @song.save
    send_file "#{Rails.root}/public/#{@song.path}/#{@song.name}.mp3", :x_sendfile => true, type: "audio/mp3", filename: @song.name+".mp3"
  end
  def download
    @song.downloaded_times+=1
    @song.save
    render json: {"id"=> @song.id, downloaded_times: @song.downloaded_times }, :callback => params[:callback]
  end
  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:name, :path, :played, :recorded_date, :downloaded_times)
  end
end
