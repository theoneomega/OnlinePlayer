namespace :songs do
  desc "leer e indexar los archivos mp3"
  task :index=> :environment  do
    Dir.glob("#{Rails.root}/public/**/**/**/**/**/*.mp3",File::FNM_CASEFOLD) do |song|
      a = "#{File.basename(song).split(" ").first[0,2]}-#{File.basename(song).split(" ").first[2,2]}-#{File.basename(song).split(" ").first[4,4]}"
      dat = Date.strptime(a,'%d-%m-%Y') rescue Date.new(2016-01-01)
      Song.create(:name => File.basename("#{song}", ".mp3"), :recorded_date => dat, :path => File.dirname("#{song.gsub(Rails.root.to_s+"/public/", "")}"), :played => 0, :downloaded_times => 0)
    end
  end
  task :update => :environment do
    added = 0
    Dir.glob("#{Rails.root}/public/**/**/**/**/**/*.mp3",File::FNM_CASEFOLD) do |song|
      a = "#{File.basename(song).split(" ").first[0,2]}-#{File.basename(song).split(" ").first[2,2]}-#{File.basename(song).split(" ").first[4,4]}"
      dat = Date.strptime(a,'%d-%m-%Y') rescue Time.now
      exist = Song.find_by_name(File.basename("#{song}", ".mp3"))
      if exist.nil?
        Song.create(:name => File.basename("#{song}", ".mp3"), :recorded_date => dat, :path => File.dirname("#{song.gsub(Rails.root.to_s+"/public/", "")}"), :played => 0, :downloaded_times => 0)
        added += 1
      end
    end
    puts "Total canciones nuevas => #{added}"
  end
 task :update_types => :environment do
    added = 0
    Dir.glob("#{Rails.root}/public/**/**/**/**/**/*.mp3",File::FNM_CASEFOLD) do |song|
      Mp3Info.open(song) do |s|
        exist = Song.find_by_name(File.basename("#{song}", ".mp3"))
        if s.tag2.COMM.nil?
          exist.audio_type = "full"
          exist.attachment = "fullgral.png"
        else
          if s.tag2.COMM.include? "predica"
            exist.audio_type = "predica"
            if s.tag2.COMM.include? "patricio"
              exist.attachment = "patricio.png"
            elsif s.tag2.COMM.include? "dany"
              exist.attachment = "dany.png"
            elsif s.tag2.COMM.include? "micha"
              exist.attachment = "micha.png"
            elsif s.tag2.COMM.include? "raquel"
              exist.attachment = "raquel.png"
            else              
              exist.attachment = "gralpredica.png"
            end
          elsif s.tag2.COMM.include? "alabanza"
             exist.audio_type = "alabanza"
            if s.tag2.COMM.include? "grupo1"
              exist.attachment = "grupo1.png"
            elsif s.tag2.COMM.include? "grupo2"
              exist.attachment = "grupo2.png"
            else
              exist.attachment = "alabanzagral.png"
            end
          else
            exist.audio_type = "full"
            exist.attachment = "fullgral.png"
          end
        end
        exist.save
      end      
    end
    puts "tipo de audios actualizados correctamente"
  end
end