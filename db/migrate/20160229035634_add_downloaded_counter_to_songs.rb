class AddDownloadedCounterToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :downloaded_times, :integer
  end
end
