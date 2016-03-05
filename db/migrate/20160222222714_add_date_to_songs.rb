class AddDateToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :recorded_date, :date
  end
end
