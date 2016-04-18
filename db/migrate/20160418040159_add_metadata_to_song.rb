class AddMetadataToSong < ActiveRecord::Migration
  def change
    add_column :songs, :artist, :string
    add_column :songs, :title, :string
    add_column :songs, :cover, :string
  end
end
