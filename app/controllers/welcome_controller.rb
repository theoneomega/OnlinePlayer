class WelcomeController < ApplicationController
  def index
  	@songs = Dir.glob("#{Rails.root}/public/CancionesFinales/**/**/**/**/*.mp3",File::FNM_CASEFOLD)
  end
 def download
 	
 end
end
