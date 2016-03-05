json.array!(@songs) do |song|
  json.extract! song, :id, :name, :path, :played, :recorded_date, :downloaded_times
  json.url song_url(song, format: :json)
end
