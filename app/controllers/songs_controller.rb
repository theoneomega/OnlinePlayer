class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update]
  load_and_authorize_resource

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all
  end
  def new
    @song = Song.new
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end


  # GET /songs/1/edit
  def edit
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :path, :played, :recorded_date, :downloaded_times, :attachment)
    end
end
