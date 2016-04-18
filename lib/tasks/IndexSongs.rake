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
      dat = Date.strptime(a,'%d-%m-%Y') rescue Date.new(2016-01-01)
      exist = Song.find_by_name(File.basename("#{song}", ".mp3"))
      if exist.nil?
        Song.create(:name => File.basename("#{song}", ".mp3"), :recorded_date => dat, :path => File.dirname("#{song.gsub(Rails.root.to_s+"/public/", "")}"), :played => 0, :downloaded_times => 0)
        added += 1
      end
    end
    puts "Total canciones nuevas => #{added}"
  end
end