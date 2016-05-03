class UploadedFilesController < ApplicationController
  before_filter :authorize_admin
  before_action :set_uploaded_file, only: [:show, :edit, :update, :destroy]
  # GET /uploaded_files
  # GET /uploaded_files.json
  def index
    @uploaded_files = UploadedFile.all
  end

  # GET /uploaded_files/1
  # GET /uploaded_files/1.json
  def show
  end

  # GET /uploaded_files/new
  def new
    @uploaded_file = UploadedFile.new
  end

  # GET /uploaded_files/1/edit
  def edit
  end

  # POST /uploaded_files
  # POST /uploaded_files.json
  def create
    @uploaded_file = UploadedFile.new(uploaded_file_params)

    respond_to do |format|
      if @uploaded_file.save
        
        system "rake songs:update"
        write_metadata(@uploaded_file.id, params[:descripcion])
     #   system "rake songs:update_types"
        
        format.html { redirect_to @uploaded_file, notice: 'Uploaded file was successfully created.' }
        format.json { render :show, status: :created, location: @uploaded_file }
      else
        format.html { render :new }
        format.json { render json: @uploaded_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploaded_files/1
  # PATCH/PUT /uploaded_files/1.json
  def update
    respond_to do |format|
      if @uploaded_file.update(uploaded_file_params)
        format.html { redirect_to @uploaded_file, notice: 'Uploaded file was successfully updated.' }
        format.json { render :show, status: :ok, location: @uploaded_file }
      else
        format.html { render :edit }
        format.json { render json: @uploaded_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploaded_files/1
  # DELETE /uploaded_files/1.json
  def destroy
    @song = Song.find_by_name(@uploaded_file.audio_file_name.gsub(".mp3",""))
    @uploaded_file.destroy    
    @song.destroy
    respond_to do |format|
      format.html { redirect_to uploaded_files_url, notice: 'Uploaded file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_uploaded_file
    @uploaded_file = UploadedFile.find(params[:id])
  end

   def write_metadata(id, descripcion)
    p "#{id} es el id && #{descripcion} es la descripcion"
    @song = UploadedFile.find(id)
    @final_song = Song.find_by_name(@song.audio_file_name.gsub(".mp3",""))
    Mp3Info.open(@song.audio.url(:default, timestamp: false).gsub("%C3%B1","ñ").gsub("%C3%B3","ó").gsub("%C3%A1","á")) do |mp3|
      mp3.tag2.COMM = descripcion
      if descripcion.include? "predica"
        @final_song.audio_type = "predica"
        if descripcion.include? "patricio"
          @final_song.attachment = "patricio.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        elsif descripcion.include? "dany"
          @final_song.attachment = "dany.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        elsif descripcion.include? "micha"
          @final_song.attachment = "micha.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        elsif descripcion.include? "raquel"
          @final_song.attachment = "raquel.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        else              
          @final_song.attachment = "gralpredica.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        end
      elsif descripcion.include? "alabanza"
         @final_song.audio_type = "alabanza"
        if descripcion.include? "grupo1"
          @final_song.attachment = "grupo1.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        elsif descripcion.include? "grupo2"
          @final_song.attachment = "grupo2.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        else
          @final_song.attachment = "alabanzagral.png"
          mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
        end
      else
        @final_song.audio_type = "full"
        @final_song.attachment = "fullgral.png"
        mp3.tag2.add_picture(File.binread(open("vendor/assets/images/#{@final_song.attachment}")))
      end


      @final_song.duration = Time.at(mp3.length).utc.strftime("%H:%M:%S").to_s
    end
    @final_song.save
   end
  # Never trust parameters from the scary internet, only allow the white list through.
  def uploaded_file_params
    params.require(:uploaded_file).permit(:audio, :descripcion)
  end

end
